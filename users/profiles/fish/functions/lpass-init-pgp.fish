function lpass-init-pgp -d "Download PGP key from LastPass"
    set -lx PGP_KEYS (lpass ls PGP/ | tail -n +1 | awk '{print substr($1,5,length($1));}')
    for key in $PGP_KEYS
        lpass show PGP/"$key" --field="Private Key" >~/"$key".asc
        chmod 0600 ~/"$key".asc
        gpg --import ~/"$key".asc
        rm ~/"$key".asc
    end
end
