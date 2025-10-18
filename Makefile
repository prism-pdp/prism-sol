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
