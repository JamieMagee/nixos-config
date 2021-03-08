{ suites, ... }: {
  ### root password is empty by default ###
  imports = suites.graphics;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/ee42c8cb-cd33-420b-8887-2ccd4ea8bffa";
      fsType = "ext4";
    };
    "/nix/store" = {
      device = "/nix/store";
      fsType = "none";
      options = [ "bind" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/78D3-12CB";
      fsType = "vfat";
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/b0acb83d-9c3f-48b1-8186-8ccf3261d709"; }];

  virtualisation.virtualbox.guest.enable = true;
}
