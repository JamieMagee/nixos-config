function lpass-init-ssh -d "Download SSH keys from LastPass"
    if test ! -d ~/.ssh/keys
        mkdir -p ~/.ssh/keys
    end
    set -lx SSH_KEYS (lpass ls SSH/ | tail -n +2 | awk '{print substr($1,5,length($1));}')
    for key in $SSH_KEYS
        lpass show SSH/"$key" --field="Private Key" >~/.ssh/keys/"$key"
        chmod 0600 ~/.ssh/keys/"$key"
        lpass show SSH/"$key" --field="Public Key" >~/.ssh/keys/"$key".pub
    end
end
