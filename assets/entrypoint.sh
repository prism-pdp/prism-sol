#!/bin/sh

if [ "$1" = "" ]; then
    /bin/ash
elif [ "$1" = "build" ]; then
    forge build
    for f in $(ls src/*.sol); do
        name=$(basename $f .sol)
        jq -c '.abi' ./out/${name}.sol/${name}.json > ./cache/${name}.abi
        abigen --abi ./cache/${name}.abi --pkg main --type ${name} --out ./go-bindings/${name}.go
    done

else
    exec "$@"
fi