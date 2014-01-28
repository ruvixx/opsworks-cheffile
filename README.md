# Setup

This will allow you to use [librarian-chef](https://github.com/applicationsonline/librarian-chef) to manage your OpsWorks cookbook dependencies as you would rubygems in a Gemfile. Edit the `Cheffile` to your heart's content with the custom cookbooks that you need to use. The `Cheffile` in the repository contains the custom cookbooks that we currently use at [Cult Cosmetics](https://www.cultcosmetics.com).

1. Clone this repo
1. `bundle`
1. `thor list`

## Why not Berkshelf?
I actually started out using [Berkshelf](https://github.com/berkshelf/berkshelf) but was frustrated by the following things:

1. Berkshelf installs `recommends` depencies and there is no way to disable this. For example, when using the newrelic cookbook, you get php, python, ms_dotnot4 ... and I had to fork Berkshelf to avoid this
1. Berkshelf maintains a global cache of cookbooks, and I wanted something that was self-contained

# Inspiration

Thanks to [ryansch](https://github.com/ryansch) for [opsworks-control-tower](https://github.com/aceofsales/opsworks-control-tower)