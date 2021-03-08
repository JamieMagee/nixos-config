{ pkgs, ... }: {
  home.packages = with pkgs; [ bitwarden-cli ];

  programs.fish = {
    enable = true;
    functions = {
      bw-login = ''
        set -Ux BW_SESSION (${pkgs.bitwarden-cli}/bin/bw login --raw jamie.magee@gmail.com)
      '';
      bw-init-ssh = ''
        set -lx keys (${pkgs.bitwarden-cli}/bin/bw list items --folderid cf72e461-2de3-4f1d-a20e-ac29013a1a88 | ${pkgs.jq}/bin/jq -c '.[] | {itemId: .id, attachment: .attachments[]} | {itemId: .itemId, attachment: {id: .attachment.id, name: .attachment.fileName}}')

        for key in $keys
          eval (echo $key | ${pkgs.jq}/bin/jq -r '. |"${pkgs.bitwarden-cli}/bin/bw get attachment \(.attachment.id) --itemid \(.itemId) --output ~/.ssh/keys/\(.attachment.name)"')
        end
      '';
      setup-keychain = ''
        # First check we're logged in
        set bw_status (${pkgs.bitwarden-cli}/bin/bw status |  ${pkgs.jq}/bin/jq -r '.status')

        if string match -q -- "unlocked" $bw_status

          set -l keys home work
          # Then check all the required keys exist
          for key in $keys
            if test ! -f ~/.ssh/keys/$key
              echo -n "Unable to find SSH key "
              set_color -o brred
              echo "$key"
              set_color normal
              echo -n "Download SSH keys using "
              set_color -o brgreen
              echo -n "bw-init-ssh"
              set_color normal
              echo -n " and run "
              set_color -o brgreen
              echo -n "setup-keychain"
              set_color normal
              echo " again."
              return 1
            end
          end

          if status is-interactive
            # SSH
            # Keys to add automatically
            for key in $keys
              # Create SSH_ASKPASS script for each key
              set -lx tmp (mktemp /tmp/pass.XXX)
              echo -e "#!/usr/bin/env/fish\n${pkgs.bitwarden-cli}/bin/bw list items --folderid cf72e461-2de3-4f1d-a20e-ac29013a1a88 --search $key | ${pkgs.jq}/bin/jq -r '.[].notes'" >>$tmp
              chmod +x $tmp
              set -lx SSH_ASKPASS $tmp
              # Add SSH key to ssh-agent
              ${pkgs.keychain}/bin/keychain --quiet ~/.ssh/keys/$key
              rm $tmp
            end

            # PGP
            # ${pkgs.keychain}/bin/keychain --quiet --agents gpg jamie.magee@gmail.com
          end

          # Run the keychain generated scripts
          if test -f ~/.keychain/(hostname)-fish
            source ~/.keychain/(hostname)-fish
          end

          if test -f ~/.keychain/(hostname)-gpg-fish
            source ~/.keychain/(hostname)-gpg-fish
          end

        else
          echo "Unable to setup SSH keys."
          echo -n "Login to BitWarden first and run "
          set_color -o brgreen
          echo "setup-keychain"
          set_color normal
          return 1
        end

      '';
    };
  };
}
