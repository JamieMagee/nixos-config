{

  imports = [ ../../profiles/develop ../../profiles/fish ];

  home-manager.users.jamie = {
    imports = [ ../profiles/fish ../profiles/gpg ];
  };

  users.users.jamie = {
    uid = 1000;
    password = "nixos";
    description = "default";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIr1ZYIVMaWmhOVW3rqJS24Ffkin4XdxfMXFR5E4mt3W"
    ];
  };
}
