{
  services.sonarr.enable = true;

  services.nginx.virtualHosts."sonarr.jamiemagee.dk" = {
    locations."/" = {
      # enableACME = true;
      proxyPass = "http://localhost:8989/";
    };
  };
}
