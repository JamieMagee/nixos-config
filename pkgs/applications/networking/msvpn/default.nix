{ stdenv, pkgs, python3Packages, pkgconfig }:

stdenv.mkDerivation rec {
  pname = "msvpn";
  version = "2020.5";

  src = builtins.fetchGit {
    url = "ssh://git@ssh.dev.azure.com:22/v3/linux-scripts/MSVPN-linux/MSVPN-linux";
    rev = "df82b07d82a6007478100b044617d64117c49655";
  };

  nativeBuildInputs = [
    python3Packages.wrapPython pkgconfig
  ];

  pythonPath = with python3Packages; [
    pycrypto packaging requests selenium pyyaml pyxdg
  ];

  buildInputs = with pkgs; [
    openconnect_pa chromium chromedriver selenium-server-standalone
  ] ++ pythonPath;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp paloalto.py $out/bin/
    wrapPythonPrograms
  '';
}
