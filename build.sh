#!/usr/bin/env bash

code=$(cat <<EOF
s" cli.fs" required
c" object.lib" save-forth
EOF
)

if [ -z "$1" ] ; then name="cli" ; else name="$1" ; fi

{ echo "$code" ; } | pforth /dev/stdin
mawk '{ print } END { n = NR ; while (n++ < 99) print "" ; }' cli.sh > "$name"
tar chvz pforth object.lib >> "$name"
chmod +x "$name"

