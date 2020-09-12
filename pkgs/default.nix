final: prev: {
  sddm-chili =
    prev.callPackage ./applications/display-managers/sddm/themes/chili { };
  msvpn = prev.callPackage ./applications/networking/msvpn { };
}
