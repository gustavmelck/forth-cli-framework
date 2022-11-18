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

config=$(cat <<EOF
main
EOF
)

dir=$(mktemp -d)
trap "rm $dir/* ; rmdir $dir" 0
tail -n +50 "$0" | tar xzC "$dir"
"$dir/pforth" -q -d "$dir/object.lib" <(echo "$config")

exit 0

