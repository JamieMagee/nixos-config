{ pkgs, lib, config, ... }: {

  home-manager.users.jamie.home.packages =
  [
     (with pkgs.dotnetCorePackages; combinePackages [
      sdk_3_1
      sdk_3_0
      sdk_2_1
      aspnetcore_3_1
      aspnetcore_3_0
      aspnetcore_2_1
    ])
  ];

}