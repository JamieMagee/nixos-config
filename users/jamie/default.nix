{ ... }:
{
  home-manager.users.jamie = {
    imports = [ 
      ../profiles/git
      ../profiles/direnv
      ../profiles/dotnet
      ../profiles/fish
      ../profiles/keychain
    ];
  };

  users.users.jamie = {
    uid = 1000;
    password = "nixos";
    description = "default";
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };
}
