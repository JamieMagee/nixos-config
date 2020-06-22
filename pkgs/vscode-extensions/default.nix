{ lib, vscode-utils }:

with lib;

(map (ext: (vscode-utils.buildVscodeMarketplaceExtension { mktplcRef = ext; }))
  (import ./extensions.nix))
