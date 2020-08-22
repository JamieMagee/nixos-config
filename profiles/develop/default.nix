{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    nodejs-14_x
  ];

}