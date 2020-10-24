{
  services.tautulli.enable = true;

  services.nginx.virtualHosts."tautulli.jamiemagee.dk" = {
    locations."/" = {
      # enableACME = true;
      proxyPass = "http://localhost:8181/";
    };
  };
}
