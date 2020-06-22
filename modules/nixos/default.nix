{ pkgs, lib, ... }: {
  imports = [
    ./packages.nix
    ./profiles/bluetooth.nix
    ./profiles/dns.nix
    ./profiles/docker.nix
    ./profiles/firmware.nix
    ./profiles/hardware.nix
    ./profiles/network.nix
    ./profiles/power.nix
    ./profiles/ssh.nix
    ./profiles/users.nix
  ];
}
