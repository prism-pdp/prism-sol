#!/bin/sh

forge build
crytic-compile --export-format echidna --output echidna/out

run-scribble.sh arm src/XZ21.sol

echidna test/echidna_XA21.sol \
    --config test/echidna.yaml \
    --contract XZ21EchidnaWrapper
