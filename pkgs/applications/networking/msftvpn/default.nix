{ stdenv, pkgs, makeWrapper, openconnect, python3, python3Packages, ... }:

stdenv.mkDerivation rec {
  pname = "msftvpn-unstable";
  version = "2020-08-11";

  src = builtins.fetchGit {
    url =
      "ssh://git@ssh.dev.azure.com:22/v3/linux-scripts/MSVPN-linux/MSVPN-linux";
    ref = "master";
    rev = "df82b07d82a6007478100b044617d64117c49655";
  };

  buildInputs = [
    (python3.withPackages (pythonPackages:
      with pythonPackages; [
        pycrypto
        packaging
        requests
        selenium
        pyyaml
        pyxdg
      ]))
  ];

  unpackPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    cp $src/paloalto.py $out/bin/msftvpn
    chmod +x $out/bin/msftvpn
  '';

  meta = with stdenv.lib; {
    description = "The (unofficial) Microsoft VPN client for Linux";
    homepage =
      "https://dev.azure.com/linux-scripts/MSVPN-linux/_git/MSVPN-linux";
    maintainers = [ maintainers.jamiemagee ];
    license = licenses.unfree;
  };
}
