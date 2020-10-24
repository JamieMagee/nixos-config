{
  services.radarr.enable = true;

  services.nginx.virtualHosts."radarr.jamiemagee.dk" = {
    locations."/" = {
      # enableACME = true;
      proxyPass = "http://localhost:8989/";
    };
  };
}
