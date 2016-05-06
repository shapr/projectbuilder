all: precheck check binary package test

.PHONY: check package publish test clean

PRECHECK = main-precheck

BINARY ?= app

include ${PROJECTBUILDER}/*/Makefile

setup: ${SETUP}

precheck: ${PRECHECK}

main-precheck:
	$(info == Precheck)
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
