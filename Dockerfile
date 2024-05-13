FROM ghcr.io/foundry-rs/foundry:latest@sha256:3bcbeab19b88d8a4245d811cf0d2cd35dbaa2042fd3f61516bae28156eedcd2a

RUN apk update \
    && apk upgrade \
    && apk add \
        vim \
        jq

WORKDIR /app

COPY --chmod=755 ./assets/abigen-1.14.0 /usr/local/bin/abigen
COPY --chmod=755 ./assets/entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
