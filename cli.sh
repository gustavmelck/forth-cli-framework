#!/usr/bin/env bash

usage=$(cat <<EOF
Usage:  $0 [options] ...

(Add usage instructions...)
EOF
)

while true ; do
    case "$1" in
        -h | --help )  echo "$usage" ; exit 0 ;;
        * )  break ;;
    esac
done

dir=$(mktemp -d)

config=$(cat <<EOF
\ s" $dir/toshell" >shell!
\ s" $dir/fromshell" shell>!
main
-shell
EOF
)

#mkfifo "$dir/toshell"
#mkfifo "$dir/fromshell"
#bash < "$dir/toshell" > "$dir/fromshell" &
trap "rm $dir/* ; rmdir $dir" 0
tail -n +100 "$0" | tar xzC "$dir"
"$dir/pforth" -q -d "$dir/object.lib" <(echo "$config")

exit 0

