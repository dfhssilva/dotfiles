dfhssilva's Dotfiles
=================

This repository uses [Dotbot][dotbot] for installation.

After cloning this repo, run `install` to automatically set up the development environment. Note that the install script is idempotent: it can safely be run multiple times.

External projects are integrated with git submodules. To upgrade submodules to their latest versions, you can periodically run `git submodule update --init --remote --merge` (merges submodule changes into the superproject). 

[dotbot]: https://github.com/anishathalye/dotbot
