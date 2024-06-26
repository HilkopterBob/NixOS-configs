# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./modules/hardware-configuration.nix
      #./modules/HP-Mini.nix
      #./asus-g15.nix
      ./modules/qemu-kvm.nix
      ./modules/desktop.nix
    ];

  # --- TODO: Copy Bootloader-Conf HERE

  # --- END Bootloader conf
 
  # NOTE SET KERNEL BOOTLOADER OPTIONS and Hostname ON INDIVIDUAL MODULE NIX  
  # networking.hostName = "NixOS"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; 

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
     # font = "Lat2-Terminus16"; not a big fan
     keyMap = "de";
  #   useXkbConfig = true; # use xkbOptions in tty.
  };

  # NOTE: DEFINE USER ACCOUNT in different module
  
  # Unfree softwares
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command"  "flakes" ];
  
  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    baobab
    btrfs-progs
    cpufrequtils
	#firewalld
    ffmpeg   
    glib #for gsettings to work   
    libappindicator
    libnotify
    openssl # required by Rainbow borders
	python3
    unzip  
    vim
    wget
    xdg-user-dirs
     
	# I normally have and use
    audacious
    mpv
    mpvScripts.mpris
    neofetch
    shotcut
        
    # Hyprland Stuff        
    btop
    cava
    cliphist
    gnome.gnome-system-monitor
    gnome.eog # eye of gnome
    grim
    hyprcursor # requires unstable channel
    hypridle # requires unstable channel
    hyprlock # requires unstable channel
    jq
    kitty
    networkmanagerapplet
    nwg-look # requires unstable channel
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    pywal
    qt6Packages.qtstyleplugin-kvantum #kvantum
	libsForQt5.qtstyleplugin-kvantum #kvantum
    qt6.qtwayland
    ranger
	rofi-wayland
    slurp
    swappy
	swaynotificationcenter
    swww
    qt5ct
    qt6ct
    wl-clipboard
    wlogout
    xdg-utils
    yad    
  ];

  programs = {
  	git.enable = true;
  	firefox.enable = true;
  	
  	hyprland = {
    	enable = true;
    	xwayland.enable = true;
  		};
  	xwayland.enable = true;
  	
  	waybar.enable = true;
  	
  	file-roller.enable = true;
  	thunar = {
  		enable = true;
  		plugins = with pkgs.xfce; [
		exo
		mousepad
		thunar-archive-plugin
		thunar-volman
  		];
  	};
  	
  	dconf.enable = true;
  };

  xdg.portal = {
  	enable = true;
  	extraPortals = with pkgs; [
    	xdg-desktop-portal-gtk
    	xdg-desktop-portal-hyprland
  	];
  };
  
  # Services (common)
  services = {
  	# for thunar to work better
  	gvfs.enable = true;
  	tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      	};
      pulse.enable = true;
      wireplumber.enable = true;
  	};
  
  	udev.enable = true;
  	envfs.enable = true;
  	dbus.enable = true;
  	
  	fstrim = {
    	enable = true;
    	interval = "weekly";
  		};
  
  	fwupd.enable = true;
  	
  	upower.enable = true;
  	
  	#flatpak.enable = true;
  };
  
  powerManagement = {
	enable = true;
	cpuFreqGovernor = "schedutil";
  };
  	
  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk
    jetbrains-mono
    font-awesome
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];
  
    
  # SECURITY
  security = {
  	pam.services.swaylock.text = "auth include login";
  	polkit.enable = true;
  	rtkit.enable = true;
  }; 

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  #networking.nftables.enable = true;
  #networking.firewall = {
	#enable = true;
	#allowedTCPPorts = [ 80 443 ];
	#allowedUDPPortRanges = [
	    #{ from = 4000; to = 4007; }
	    #{ from = 8000; to = 8010; }
	    #];
  #};
  #sudo firewall-cmd --add-port=1025-65535/tcp --permanent
  #sudo firewall-cmd --add-port=1025-65535/udp --permanent
      
  systemd.services = {
  	NetworkManager-wait-online.enable = false;
  	firewalld.enable = true;
  }; 
  
  # Masking sleep, hibernate, suspend.. etc
  

  # --- TODO: Copy Swap Config Here

  # --- End Swap Config
  
  # Enable the X11 windowing system.
  # services.xserver.enable = true;  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";  

  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  
    # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}


