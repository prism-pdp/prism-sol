IMAGE_NAME = prism/prism-sol
ETH_SECURITY_TOOLBOX = est

.PHONY: test

build-img:
	docker build -t $(IMAGE_NAME) -f docker/Dockerfile.foundry .	
	$(MAKE) bindings

bindings:
	docker create --name prism-sol-temp $(IMAGE_NAME)
	docker cp prism-sol-temp:/opt/prism-net/bindings/XZ21.go ./go-bindings/XZ21.go
	docker rm prism-sol-temp

shell:
	docker run -it --rm $(IMAGE_NAME)

test: build-img
	docker run -it --rm $(IMAGE_NAME) forge test -vvv --gas-report

slither:
	docker run -it --rm -v "$(PWD)":/share -w /share \
		$(ETH_SECURITY_TOOLBOX) \
		bash -lc 'slither .'

build-inspection:
	docker build -t prism/prism-sol-inspection -f docker/Dockerfile.inspection .

scribble: build-scribble
	docker run -it --rm -v "$(PWD)":/share -w /share \
		prism/prism-sol-scribble \
		sh
#		bash -lc 'scribble --solc-version 0.8.19 --unsafe . --out-dir ./scribble-out --force'

inspection-sh:
	docker run -it --rm -v "$(PWD)":/workspace \
		prism/prism-sol-inspection \
		bash

inspect-mythril:
	@date --rfc-3339=seconds
	@$(MAKE) mythril-cmd CMD="analyze src/XZ21.sol \
		--solv 0.8.24 \
		--max-depth 32 --call-depth-limit 5 \
		--strategy weighted-random -b 3 -t 3 \
		--execution-timeout 180 --solver-timeout 1500 \
		--parallel-solving --pruning-factor 0.3 --enable-summaries \
		--no-onchain-data"
	@date --rfc-3339=seconds

mythril-sh:
	$(MAKE) mythril-cmd CMD=bash

mythril-cmd:
	@docker run -it --rm -v "$(PWD)":/share -w /share \
		mythril/myth:0.24.8 \
		$(CMD)

echidna-sh:
	$(MAKE) echidna-cmd CMD=bash

echidna-cmd:
	@docker run -it --rm -v "$(PWD)":/share -w /share \
		--user 1000:1000 \
		prism/echidna \
		$(CMD)

echidna-build:
	docker build -t prism/echidna -f docker/Dockerfile.echidna .
