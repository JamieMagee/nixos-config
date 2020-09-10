{ ... }: {
  networking.networkmanager = {
    enable = true;
    dns = "dnsmasq";
  };
}
