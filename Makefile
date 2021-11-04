REPO        = authexec/docker-sgx-tools
TAG        ?= latest
VOLUME     ?= $(shell pwd)

build:
	docker build -t $(REPO):$(TAG) .

push: login
	docker push $(REPO):$(TAG)

pull:
	docker pull $(REPO):$(TAG)

run:
	docker run --rm -it -v $(VOLUME):/usr/src/app/ $(REPO):$(TAG) bash

login:
	docker login
