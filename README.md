dfhssilva's Dotfiles
=================

This repository uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.

It is organized such that each program's configuration is in its own folder, with the exception of single file configurations, which are in the misc (miscellaneous) folder.

After cloning this repo, run `install` to automatically set up the development environment. Note that the install script is idempotent: it can safely be run multiple times.

External projects are integrated with git submodules. To upgrade submodules to their latest versions, you can periodically run `git submodule update --init --remote --merge` (merges submodule changes into the superproject). 

# AwesomeWM desktop

## System dependencies:
- Check the `pacman-pkglist.txt` file in the misc folder.
- Install Dependencies manually or do `pacman -S --needed - < misc/pacman-pkglist.txt` to install every package in the list.

### Things to do after install:

#### betterlockscreen:
- Setup the lock screen wallpaper
```
betterlockscreen -u ~/.config/awesome/wallpaper.jpg
```
- Activate lock screen after sleep/suspend
```
systemctl enable betterlockscreen@$USER
```

#### optimus-manager (nvidia gpu configuration):
- Setup the config file:
```
cp misc/optimus-manager.conf /etc/optimus-manager
```
- [Allow prime-switch to be run by the user](https://github.com/Askannz/optimus-manager/issues/404). Append to /etc/sudoers (change \<username\>):
```
<username> ALL = NOPASSWD: /usr/bin/prime-switch
```

### Program list

- [AwesomeWM](https://awesomewm.org/) as the window manager
- [Roboto](https://fonts.google.com/specimen/Roboto) as the system font
- [Hack](https://github.com/source-foundry/Hack) as the termial font
- [Rofi](https://github.com/DaveDavenport/rofi) for the app launcher
- [picom](https://github.com/yshui/picom) for the compositor (transparency and animations)
- [betterlockscreen](https://github.com/betterlockscreen/betterlockscreen) the lockscreen application
- [gnome-polkit] recommend using the gnome-polkit as it integrates nicely for elevating programs that need root access
- [Nordic Darker](https://github.com/EliverLara/Nordic) as GTK theme
- [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) as icon theme
- [gnome-screenshot](https://gitlab.gnome.org/GNOME/gnome-screenshot) as screenshot tool
- [pnmixer](https://github.com/nicklan/pnmixer) Audio Tray icon
- [network-manager-applet](https://gitlab.gnome.org/GNOME/network-manager-applet) nm-applet is a Network Manager Tray display from GNOME
- [xfce4-power-manager](https://docs.xfce.org/xfce/xfce4-power-manager/start) XFCE4's power manager is excellent and a great way of dealing with sleep, monitor timeout, and other power management features.
