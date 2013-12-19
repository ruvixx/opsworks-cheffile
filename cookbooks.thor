require 'thor'
require 'fog'
require 'zlib'
require 'archive/tar/minitar'

class Cookbooks < Thor
  include Archive::Tar
  include Thor::Actions

  desc 'install', 'Install cookbooks from Berksfile'
  def install
    run 'bundle exec berks install --path cookbooks'
  end

  desc 'update', 'Update cookbook versions from Berksfile'
  def update
    run 'bundle exec berks update'
  end

  desc 'package', 'Package cookbooks into a tgz file'
  def package
    puts "Packaging cookbooks"

    FileUtils.mkdir_p('tmp')
    tgz = Zlib::GzipWriter.new(File.open(cookbook_tarball_name, 'wb'))

    package = Dir['cookbooks/*']

    Minitar.pack(package, tgz)
  end

  desc 'upload ACCESS_KEY SECRET_ACCESS_KEY', 'Upload cookbooks to S3'
  option :install, type: :boolean, default: false
  option :package, type: :boolean, default: true
  def upload(access_key, secret_access_key)
    save_credentials(access_key, secret_access_key)

    if options[:install]
      if !install
        raise Thor::Error, "Cookbook installation failed; aborting upload."
      end

      puts
    end

    if options[:package]
      if !package
        raise Thor::Error, "Cookbook packaging failed; aborting upload."
      end

      puts
    end

    remote_file = directory.files.head(cookbook_tarball_name)
    remote_file.destroy if remote_file

    puts "Uploading to S3"

    directory.files.create(
      key: "cookbooks.tgz",
      body: File.open(cookbook_tarball_name)
    )
  end

  no_tasks do
    def save_credentials(access_key, secret_access_key)
      @access_key = access_key
      @secret_access_key = secret_access_key
    end

    def connection
      Fog::Storage.new({
        provider: 'AWS',
        aws_access_key_id: @access_key,
        aws_secret_access_key: @secret_access_key,
        region: 'us-west-2'
      })
    end

    def directory
      connection.directories.get('cult-cookbooks')
    end

    def cookbook_tarball_name
      File.join('tmp', 'cookbooks.tgz')
    end
  end
end
