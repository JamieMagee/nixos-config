{
  ### root password is empty by default ###
  imports = [
    ../profiles/ssh
    ../profiles/networking/dns
    ../profiles/networking/networkmanager
    ../users/jamie
    ../users/root
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostId = "cda96004";

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "zfs" ];

  fileSystems."/" = {
    device = "zpool/ROOT/nixos";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/EFI";
    fsType = "vfat";
  };

  fileSystems."/nix" = {
    device = "zpool/NIX/nix";
    fsType = "zfs";
  };
  fileSystems."/home" = {
    device = "zpool/HOME/home";
    fsType = "zfs";
  };

  swapDevices = [ ];

  services.qemuGuest.enable = true;
}
