#!/bin/sh

run-scribble.sh disarm src/XZ21.sol
forge build
aderyn --output aderyn_report.md .