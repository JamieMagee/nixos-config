{ pkgs, lib, config, ... }: {

  services.stubby = {
    enable = true;
    listenAddresses = [ "127.0.0.1@5453" "0::1@5453" ];
    upstreamServers = ''
      - address_data: 9.9.9.9
        tls_auth_name: "dns.quad9.net"
      - address_data: 1.1.1.1
        tls_auth_name: "cloudflare-dns.com"
      - address_data: 1.0.0.1
        tls_auth_name: "cloudflare-dns.com"
      - address_data: 2620:fe::fe
        tls_auth_name: "dns.quad9.net"
      - address_data: 2606:4700:4700::1111
        tls_auth_name: "cloudflare-dns.com"
      - address_data: 2606:4700:4700::1001
        tls_auth_name: "cloudflare-dns.com"
    '';
  };

  services.dnsmasq = {
    enable = true;
    servers = [ "127.0.0.1#5453" "::1#5453" ];
    extraConfig = ''
      no-resolv
    '';
  };

  networking.networkmanager.dns = "dnsmasq";

}