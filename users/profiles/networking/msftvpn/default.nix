{ pkgs, ... }: {
  home.packages = with pkgs; [ openconnect ];
  xdg.configFile."msftvpn/msftvpn.yaml".text = ''
    host_uid: bc025921-88cd-41d5-814e-cb3e5fc2d239
    msad_user: jamagee@microsoft.com
    server: london.msftvpn-alt.ras.microsoft.com
    run_openconnect: true
    pipe_networkmanager: false
    driver: ${pkgs.chromedriver}/bin/chromedriver
  '';
}
