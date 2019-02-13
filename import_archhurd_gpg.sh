#!/bin/bash

set -e

ARCHWEBDIR=/srv/http/archweb

cp -v /usr/bin/pacman-key /tmp/archhurdpacman-key

patch -N /tmp/archhurdpacman-key <<'EOF'
--- /usr/bin/pacman-key	2018-07-27 03:33:58.000000000 +0000
+++ /tmp/archhurdpacman-key	2018-07-30 14:35:25.378309392 +0000
@@ -622,11 +622,6 @@
 	exit 1
 fi
 
-if (( (ADD || DELETE || EDITKEY || IMPORT || IMPORT_TRUSTDB || INIT || LSIGNKEY || POPULATE || RECEIVE || REFRESH || UPDATEDB) && EUID != 0 )); then
-	error "$(gettext "%s needs to be run as root for this operation.")" "pacman-key"
-	exit 1
-fi
-
 CONFIG=${CONFIG:-/etc/pacman.conf}
 if [[ ! -r "${CONFIG}" ]]; then
 	error "$(gettext "%s configuration file '%s' not found.")" "pacman" "$CONFIG"
EOF

env PACMAN_KEYRING_DIR=/tmp/archhurdgnupg /tmp/archhurdpacman-key --init
env PACMAN_KEYRING_DIR=/tmp/archhurdgnupg /tmp/archhurdpacman-key --populate archhurd

$ARCHWEBDIR/env/bin/python $ARCHWEBDIR/manage.py pgp_import /tmp/archhurdgnupg/pubring.gpg

rm -rv /tmp/archhurdgnupg
rm -v /tmp/archhurdpacman-key
