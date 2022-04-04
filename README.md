dfhssilva's Dotfiles
=================

This repository uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.

It is organized such that each program's configuration is in its own folder, with the exception of single file configurations, which are in the misc (miscellaneous) folder.

After cloning this repo, run `install` to automatically set up the development environment. Note that the install script is idempotent: it can safely be run multiple times.

External projects are integrated with git submodules. To upgrade submodules to their latest versions, you can periodically run `git submodule update --init --remote --merge` (merges submodule changes into the superproject). 
