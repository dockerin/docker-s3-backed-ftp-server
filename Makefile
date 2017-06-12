docker_tag 	= dockerin/docker-s3-backed-ftp-server

UNAME_S         := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    APP_HOST            := localhost
endif
ifeq ($(UNAME_S),Darwin)
    APP_HOST            := $(shell boot2docker ip)
endif

build:
	docker build -t $(docker_tag) .

bash:
	docker run --rm -it $(docker_tag) bash

run:
	$(eval ID := $(shell docker run -d ${docker_tag}))
	$(eval IP := $(shell docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${ID}))
	@echo "Running ${ID} @ ftp://${IP}"
	@docker attach ${ID}
	@docker kill ${ID}
