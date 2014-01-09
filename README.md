# Setup

This will allow you to use [librarian-chef](https://github.com/applicationsonline/librarian-chef) to manage your OpsWorks cookbook dependencies as you would rubygems in a Gemfile. Edit the `Cheffile` to your heart's content with the custom cookbooks that you need to use. The `Cheffile` in the repository contains the custom cookbooks that we currently use at [Cult Cosmetics](https://www.cultcosmetics.com).

1. Clone this repo
1. `bundle`
1. `thor list`

# Inspiration

Thanks to [ryansch](https://github.com/ryansch) for [opsworks-control-tower](https://github.com/aceofsales/opsworks-control-tower)