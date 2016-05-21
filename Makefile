# http://clarkgrubb.com/makefile-style-guide

## Prologue
# Boilerplate variables
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

# our global, user callable targets
.PHONY: check package test publish clean
# our usually not user callable targets
.PHONY: setup precheck main-precheck
# our variables with sane defaults
PRECHECK = main-precheck
BINARY ?= app
define newline


endef



## targets
all: precheck check binary package test

include ${PROJECTBUILDER}/*/Makefile

setup: ${SETUP}

precheck: ${PRECHECK}

main-precheck:
	$(info == Precheck)
	@[ -e "${PWD}/Makefile" ] || touch "${PWD}/Makefile"
	@if ! tail -n 1 ${PWD}/Makefile | grep -q "PROJECTBUILDER"; then \
		sed -i '/PROJECTBUILDER/d' ${PWD}/Makefile; \
		echo 'include $${PROJECTBUILDER}/Makefile' >> ${PWD}/Makefile; \
	fi

check: ${CHECK}

binary: ${BINARY}

package: ${PACKAGE}

test: ${TEST}

clean: ${CLEAN}

publish: ${PUBLISH}
