FROM debian:bullseye-slim AS builder

ARG GETH_ALLTOOLS="geth-alltools-linux-amd64-1.14.3-ab48ba42"

RUN apt-get update && apt-get install -y \
    wget

RUN wget -O /tmp/${GETH_ALLTOOLS}.tar.gz https://gethstore.blob.core.windows.net/builds/${GETH_ALLTOOLS}.tar.gz
RUN tar zxf /tmp/${GETH_ALLTOOLS}.tar.gz -C /tmp
RUN mkdir -p /usr/local/geth/bin
RUN cp /tmp/${GETH_ALLTOOLS}/abigen   /usr/local/geth/bin/
RUN cp /tmp/${GETH_ALLTOOLS}/bootnode /usr/local/geth/bin/
RUN cp /tmp/${GETH_ALLTOOLS}/clef     /usr/local/geth/bin/
RUN cp /tmp/${GETH_ALLTOOLS}/evm      /usr/local/geth/bin/
RUN cp /tmp/${GETH_ALLTOOLS}/geth     /usr/local/geth/bin/
RUN cp /tmp/${GETH_ALLTOOLS}/rlpdump  /usr/local/geth/bin/

FROM ghcr.io/foundry-rs/foundry:latest@sha256:3bcbeab19b88d8a4245d811cf0d2cd35dbaa2042fd3f61516bae28156eedcd2a

COPY --from=builder /usr/local/geth/bin/* /usr/local/bin

RUN apk update \
    && apk upgrade \
    && apk add \
        vim \
        jq

WORKDIR /opt/prism-net

COPY lib /opt/prism-net/lib
COPY src /opt/prism-net/src
COPY test /opt/prism-net/test

RUN forge build

ENV NUM_ACCOUNTS=6
ENV BALANCE_ACCOUNTS=300
ENV RPC_HOST=0.0.0.0
ENV RPC_PORT=8545
ENV WALLET_MNEMONIC="chaos knee unit sing method banana chicken quote script boat crouch pig"
ENV PRISM_DIR=/opt/prism-net
ENV PRISM_BINDINGS_DIR=$PRISM_DIR/bindings
ENV PRISM_DATA_DIR=/var/lib/prism-net
ENV PRISM_CACHE_DIR=$PRISM_DATA_DIR/cache

COPY --chmod=755 ./docker/entrypoint.sh /entrypoint.sh

RUN mkdir -p $PRISM_CACHE_DIR
RUN mkdir -p $PRISM_BINDINGS_DIR

RUN /entrypoint.sh bindings

ENTRYPOINT [ "/entrypoint.sh" ]
