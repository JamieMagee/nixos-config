final: prev: {
  sddm-chili =
    prev.callPackage ./applications/display-managers/sddm/themes/chili { };
  my-extensions =
    prev.callPackage ./applications/editors/vscode/my-extensions { };
}
