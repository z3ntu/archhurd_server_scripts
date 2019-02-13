#!/bin/bash

set -e

ln -sfv $(pwd)/archweb-pgp_import-pacman-hook /etc/pacman.d/hooks/archweb-pgp_import.hook
ln -sfv $(pwd)/archweb-pgp_import.service     /etc/systemd/system/archweb-pgp_import.service
ln -sfv $(pwd)/archweb-reporead.service       /etc/systemd/system/archweb-reporead.service

cp -v $(pwd)/import_archhurd_gpg.sh             /usr/local/bin/import_archhurd_gpg.sh
