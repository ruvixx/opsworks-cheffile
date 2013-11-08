# Setup

This setup assumes you have 2 repositories, one that stores the `Berksfile` and one that stores the actual cookbooks. This is because OpsWorks requires cookbooks to be in the root of the github repo that it pulls from, so you can't just put them in a subfolder called cookbooks. Sadly, berkshelf requires you to vendor your cookbooks into a subfolder or another folder.

See our [opsworks-custom-cookboks](git@github.com:CultConspiracy/opsworks-custom-cookbooks.git) repo for an example

1. Clone this repo
1. Clone your opsworks-custom-cookbooks repo in at the same level in the folder hierarchy as this repo (meaning it will put cookbooks in `../opsworks-custom-cookbooks`)
1. `bundle`
1. `./install_cookbooks`


If you want to update the versions of any of the cookbooks, just `./update_cookbooks`