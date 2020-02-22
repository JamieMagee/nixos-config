{ pkgs, lib, config, ... }:
with lib;
with types; {
  options = {
    device = mkOption { type = strMatching "(home|work)-(laptop|desktop|vm)"; };
    deviceSpecific = mkOption { type = attrs; };
  };
  config = {
    deviceSpecific = let
      device = config.device;
    in rec {
      isLaptop = (!isNull (builtins.match ".*laptop" device));
    };
  };
}
