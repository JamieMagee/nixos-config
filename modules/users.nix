{ config, pkgs, lib, ... }: {
  security.apparmor.enable = true;
  programs.firejail.enable = true;
  users.mutableUsers = false;
  users.users.jamie = {
    isNormalUser = true;
    extraGroups = [
      "sudo"
      "wheel"
      "audio"
      "docker"
    ];
    uid = 1000;
    password = "";
  };
  
  
  systemd.services."user@" = {
    serviceConfig = {
      Restart = "always";
    };
  };

security.sudo = {
    enable = true;
    extraConfig = ''
      jamie ALL = (root) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild switch
    '';
  };
  home-manager.useUserPackages = true;
}