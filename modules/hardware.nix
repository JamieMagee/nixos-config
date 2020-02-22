{ pkgs, config, lib, ... }: {
  boot = {
    supportedFilesystems = [ "zfs" ];
    loader = {
      systemd-boot.enabled = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
