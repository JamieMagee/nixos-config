{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    nodejs-13_x
    (with dotnetCorePackages; combinePackages [ sdk_3_1 sdk_3_0 sdk_2_1 ])
  ];

}
