.PHONY: test

docker-run:
	docker run -it --rm \
		--workdir /home/foundry \
		-v $(PWD):/home/foundry \
		ghcr.io/foundry-rs/foundry:latest@sha256:3bcbeab19b88d8a4245d811cf0d2cd35dbaa2042fd3f61516bae28156eedcd2a \
		'$(CMD)'

test:
	make docker-run CMD='forge test'

shell:
	make docker-run CMD='/bin/sh'
