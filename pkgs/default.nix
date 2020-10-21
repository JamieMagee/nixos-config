final: prev: {
  sddm-chili =
    prev.callPackage ./applications/display-managers/sddm/themes/chili { };
  msftvpn = prev.callPackage ./applications/networking/msftvpn { };
}
