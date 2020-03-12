{ pkgs, config, lib, ... }: {
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
    ports = [ 2222 ];
  };

  users.users.jamie.openssh.authorizedKeys.keys =
  ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIr1ZYIVMaWmhOVW3rqJS24Ffkin4XdxfMXFR5E4mt3W"];
}