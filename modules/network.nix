{ pkgs, lib, config, ... }: {
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
    };
  };
}