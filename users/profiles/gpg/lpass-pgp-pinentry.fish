echo OK

while read -la cmd
    switch "$cmd"

        case GETPIN
            if test "$passphrase" = 1
                echo "D "(lpass show 'Secure Notes'/yadm --notes)
            else
                echo "D "(lpass show PGP/keybase --field="Passphrase")
            end
            echo OK

        case 'SETDESC *'
            if string match -q -r -i -- ".*enter( this)? passphrase.*" "$cmd"
                set -g passphrase 1
            end
            echo OK

        case
        case '*'
            echo OK
    end
end
