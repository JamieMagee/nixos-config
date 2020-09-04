#!/usr/bin/env nix-shell
#!nix-shell -i bash -p git-crypt gnupg pinentry-curses lastpass-cli

set -euo pipefail

mkdir -p /root/.config/lpass
mkdir -p /root/.local/share/lpass

lpass login jamie.magee@gmail.com

pkill gpg-agent
gpg-agent --daemon --pinentry-program "$(which pinentry-curses)"

PGP_KEYS=$(lpass ls PGP/ | tail -n +1 | awk '{print substr($1,5,length($1));}')
for KEY in $PGP_KEYS; do
  lpass show PGP/"$KEY" --field="Private Key" >~/"$KEY".asc
  chmod 0600 ~/"$KEY".asc
  gpg --import ~/"$KEY".asc
  rm ~/"$KEY".asc
done

cd /etc/nixos
git-crypt unlock

sudo -H -u jamie bash -c "nix-build --eval '{}' --no-out-link"