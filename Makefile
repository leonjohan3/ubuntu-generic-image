IMAGE_VERSION = 1.0.0
IMAGE_NAME = ubuntu-generic:$(IMAGE_VERSION)
DOCKER_REPO = leonjohan3atyahoodotcom/$(IMAGE_NAME)

.PHONY: build
build:
	git diff --quiet
	test -z "$$(git status --porcelain)" || exit 1
	docker build -t $(IMAGE_NAME) .
	TAG=$$(docker image ls $(IMAGE_NAME) | head -2 | tail -1 | awk '{print $$3}') && docker tag $$TAG $(DOCKER_REPO)

.PHONY: deploy
deploy: build
	docker push $(DOCKER_REPO)
