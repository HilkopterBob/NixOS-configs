# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9942929e-fba8-4728-85dc-369a98a79b13";
      fsType = "ext4";
    };

  fileSystems."/efi" =
    { device = "/dev/disk/by-uuid/47A3-EBB9";
      fsType = "vfat";
    };

  #swapDevices =
  #  [ { device = "/dev/disk/by-uuid/6fe113f3-10a6-4413-8e16-94c4c0b55a97"; }
  #  ];

  fileSystems."/home/ja/00-Shared-Drives/Common-nvme" =
    { device = "/dev/disk/by-uuid/e127528d-777a-4c14-a492-da23db715427";
      fsType = "ext4";
    };

  #fileSystems."/home/ja/00-Shared-Drives/Common-HDD" =
  #  { device = "/dev/disk/by-uuid/7ef0da9b-4f92-4adb-a7f5-45d7038891e8";
  #    fsType = "ext4";
  #  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
