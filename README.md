# Nicks Experimental NixOS-Flake!

__shamelessly stolen from JaKoolit!__

## Install
to install, just copy everyting to /etc/nixos , copy the hardware-configuration.nix into the modules dir  
and edit the `nicks-configuration.nix` everywhere you find the `TODO:` keyword. 
Install with:
`sudo nixos-rebuild switch --flake .#NixOS`

*Sidenote*:  the prefix for the config is there to protect your configuration.nix from being overwritten, as  
we need the file to donor the individual `BOOT` and `systemd-hybernate/-sleep` config.