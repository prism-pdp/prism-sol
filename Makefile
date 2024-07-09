.PHONY: test build

docker-build:
	docker compose build sol-compiler

docker-run:
	docker compose run -it --rm sol-compiler $(CMD)

test:
	make docker-run CMD='forge test'

build:
	$(MAKE) docker-run CMD="build"

shell:
	make docker-run CMD='/bin/sh'
