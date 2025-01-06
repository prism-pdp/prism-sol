IMAGE_NAME = prism/prism-sol

.PHONY: test

build-img:
	docker build -t $(IMAGE_NAME) .	
	$(MAKE) bindings

bindings:
	docker create --name prism-sol-temp $(IMAGE_NAME)
	docker cp prism-sol-temp:/opt/prism-net/bindings/XZ21.go ./go-bindings/XZ21.go
	docker rm prism-sol-temp

shell:
	docker run -it --rm $(IMAGE_NAME)

test:
	docker run -it --rm $(IMAGE_NAME) forge test -vvv --gas-report
