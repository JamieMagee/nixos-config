function setup-keychain -d "Setup SSH keys using keychain and lastpass"

    # First check we're logged in
    set lastpass_status (lpass status)
    if string match -q -- "Logged in*" $lastpass_status

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
                echo -n "lpass-ssh-init"
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
            set -lx DISPLAY fake
            # SSH
            # Keys to add automatically
            for key in $keys
                # Create SSH_ASKPASS script for each key
                set -lx tmp (mktemp /tmp/pass.XXX)
                echo -e "#!/usr/bin/env fish\nlpass show SSH/$key --field=\"Passphrase\"\n" >>$tmp
                chmod +x $tmp
                set -lx SSH_ASKPASS $tmp
                # Add SSH key to ssh-agent
                keychain --quiet ~/.ssh/keys/$key
                rm $tmp
            end

            # PGP
            keychain --quiet --agents gpg jamie.magee@gmail.com
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
        echo -n "Login to LastPass first and run "
        set_color -o brgreen
        echo "setup-keychain"
        set_color normal
        return 1
    end

end