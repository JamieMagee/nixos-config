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

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  swapDevices = [ ];

  virtualisation.virtualbox.guest.enable = true;
}
