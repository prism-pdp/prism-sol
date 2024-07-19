IMAGE_NAME = dpduado-sol

.PHONY: test

build-img:
	docker build -t $(IMAGE_NAME) .	

shell:
	docker run -it --rm --entrypoint sh $(IMAGE_NAME)

test:
	docker run -it --rm --volume .:/app $(IMAGE_NAME) test -vvv
