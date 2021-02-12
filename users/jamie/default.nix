{ ... }:
{
  home-manager.users.jamie = {
    imports = [ ../profiles/git ../profiles/direnv ];
  };

  users.users.jamie = {
    uid = 1000;
    password = "nixos";
    description = "default";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
