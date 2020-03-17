{ pkgs, config, lib, ... }: {

  services.tlp = {
    enable = config.deviceSpecific.isLaptop;
  };

}