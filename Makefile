IMAGE_NAME = dpduado-sol

.PHONY: test

build-img:
	docker build -t $(IMAGE_NAME) .	

build-go:
	docker run -it --rm --volume .:/app $(IMAGE_NAME) build

shell:
	docker run -it --rm --volume .:/app $(IMAGE_NAME)

test:
	docker run -it --rm --volume .:/app $(IMAGE_NAME) forge test -vvv --gas-report
