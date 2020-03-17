{ pkgs, lib, config, ... }: {

  networking = {
    hostId = "abcdef12";
    networkmanager.enable = true;
    firewall = {
      enable = true;
    };
  };

}