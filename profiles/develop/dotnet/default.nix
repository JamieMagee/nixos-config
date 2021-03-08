{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    (with dotnetCorePackages;
      combinePackages [ sdk_3_0 sdk_3_1 aspnetcore_3_1 aspnetcore_3_0 ])
    jetbrains.rider
  ];
}
