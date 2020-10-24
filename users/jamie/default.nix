{ config, lib, pkgs, ... }:
let inherit (lib) fileContents;
in {

  imports = [ ../../profiles/graphical ];

  home-manager.users.jamie = {
    imports = [ ];
  };

  users.users.jamie = {
    uid = 1000;
    hashedPassword = fileContents ../../secrets/jamie;
    description = "Jamie Magee";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIr1ZYIVMaWmhOVW3rqJS24Ffkin4XdxfMXFR5E4mt3W"
    ];
  };
}
