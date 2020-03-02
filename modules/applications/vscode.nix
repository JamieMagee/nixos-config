{ pkgs, lib, config, ... }: {

  home-manager.users.jamie.programs.vscode = {
    enable = true;
    extensions = [
      # pkgs.vscode-extensions.DavidAnson.vscode-markdownlint
      # Equinusocio.vsc-material-theme
      # Equinusocio.vsc-material-theme-icons
      # Orta.vscode-jest
      # PeterJausovec.vscode-docker
      # eamodio.gitlens
      # eg2.tslint
      # esbenp.prettier-vscode
      # formulahendry.auto-close-tag
      # formulahendry.auto-rename-tag
      # formulahendry.code-runner
      # foxundermoon.shell-format
      # gio00.fish
      # James-Yu.latex-workshop
      # jithurjacob.nbpreviewer
      # dotjoshjohnson.xml
      # lunaryorn.fish-ide
      # ms-azuretools.vscode-azurefunctions
      # ms-python.python
      # ms-vscode.azure-account
      # ms-vscode.csharp
      # ms-vscode.mono-debug
      # ms-vscode.PowerShell
      # pnp.polacode
      # redhat.vscode-yaml
      # streetsidesoftware.code-spell-checker
      # vscoss.vscode-ansible
    ];
  };

}