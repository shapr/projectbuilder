# if we have a dockerfile and docker installed
ifneq ($(wildcard Dockerfile),)
ifneq ($(shell which docker),)

# assume we should be a docker package
PACKAGE ?= docker-package

# if we don't have an auth file, assume we're not logged in to publish
ifeq ($(wildcard ${HOME}/.docker/config.json),)
# if DOCKER_PASSWORD isn't set, then we can't even login
ifdef DOCKER_PASSWORD
DOCKER_LOGIN = $(shell docker login -e="${DOCKER_EMAIL}" -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}" </dev/null)
$(info == Results of Docker Login: ${DOCKER_LOGIN})
endif
endif # wildcard config.json

# if we don't already have a docker tag set
ifndef DOCKER_TAG

# try to set an org from our logged in user, if it's not already set
DOCKER_ORG ?= $(shell awk -F '"' '$$2 == "auth" {print $$4; exit}' \
					~/.docker/config.json \
				| base64 -d \
				| awk -F: '{print $$1}')
# if we still don't have an org, don't set a tag
ifeq (${DOCKER_ORG},)
$(warning == Docker detected, but unable to determine $$DOCKER_ORG and $$DOCKER_TAG is empty. Not publishing with docker.)
else
DOCKER_TAG ?= ${DOCKER_ORG}/$(notdir ${PWD})
endif # DOCKER_ORG

endif # DOCKER_TAG

# if we still don't have a tag set, don't publish with docker
ifdef DOCKER_TAG
PUBLISH ?= docker-publish
endif # DOCKER_TAG

endif # shell which docker
endif # wildcard Dockerfile

docker-package: ${BINARY}
	$(info == Building Docker image)
	docker build \
	-t ${DOCKER_TAG} \
	--label org.label-schema.schema-version="1.0" \
	--label org.label-schema.build-date="$(BUILDDATETIME)" \
	--label org.label-schema.version="${COMMITHASH}" \
	.

docker-publish:
	$(info == Pushing Docker image)
	docker push ${DOCKER_TAG}
