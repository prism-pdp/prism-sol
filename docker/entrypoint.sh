#!/bin/sh

function get_addr()
{
    index="$1"
    cast wallet derive-private-key "$WALLET_MNEMONIC" $index | sed -n 2p | cut -d ':' -f 2 | tr -d ' ' | cut -c 3-
}

function get_key()
{
    index="$1"
    cast wallet derive-private-key "$WALLET_MNEMONIC" $index | sed -n 3p | cut -d ':' -f 2 | tr -d ' ' | cut -c 3-
}

if [ "$1" = "" ]; then
	/bin/ash
elif [ "$1" = "deploy" ]; then
	contract="$2"
	private_key="$3"
	args="$4"
	forge create \
		--private-key ${private_key} \
		src/${contract}.sol:${contract} \
		--constructor-args ${args} > $PRISM_CACHE_DIR/deploy.log
	cat $PRISM_CACHE_DIR/deploy.log | grep 'Deployed to:' | cut -d ':' -f 2 | tr -d ' ' | cut -c 3-
elif [ "$1" = "show-accounts" ]; then
    for i in $(seq $NUM_ACCOUNTS)
    do
        num=$((i-1))
        address=$(get_addr $num)
        privkey=$(get_key  $num)
        echo "ADDRESS_$num=$address"
        echo "PRIVKEY_$num=$privkey"
    done
elif [ "$1" = "bindings" ]; then
    for f in $(ls src/*.sol); do
        name=$(basename $f .sol)
        pkg=$(echo $name | tr 'A-Z' 'a-z')
        jq -c '.abi' ./out/${name}.sol/${name}.json > $PRISM_BINDINGS_DIR/${name}.abi
        jq -c -r '.bytecode.object' ./out/${name}.sol/${name}.json > $PRISM_BINDINGS_DIR/${name}.bin
        abigen --abi $PRISM_BINDINGS_DIR/${name}.abi --bin $PRISM_BINDINGS_DIR/${name}.bin --pkg $pkg --type ${name} --out $PRISM_BINDINGS_DIR/${name}.go
    done
elif [ "$1" = "start" ]; then
    anvil \
        --host $RPC_HOST \
        --port $RPC_PORT \
        --accounts $NUM_ACCOUNTS \
        --balance $BALANCE_ACCOUNTS \
        --mnemonic "$WALLET_MNEMONIC" \
        --block-time 5
else
    exec "$@"
fi
