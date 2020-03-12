{ pkgs, lib, ... }: {
  imports = [
    ./packages.nix
    ./profiles/dns.nix
    ./profiles/hardware.nix
    ./profiles/network.nix
    ./profiles/ssh.nix
    ./profiles/users.nix
  ];
}