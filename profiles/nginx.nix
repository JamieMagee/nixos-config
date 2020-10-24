{ pkgs, config, lib, ... }: {
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
  security.acme.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
}
