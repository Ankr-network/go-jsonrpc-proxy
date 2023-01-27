BUILD_DIR ?= build
BUILD_PACKAGE ?= ./cmd

BINARY_NAME ?= go-jsonrpc-proxy
VERSION ?= $(shell git describe --tags --exact-match 2>/dev/null || git symbolic-ref -q --short HEAD)
COMMIT_HASH ?= $(shell git rev-parse --short HEAD 2>/dev/null)
BUILD_DATE ?= $(shell date +%FT%T%z)
LDFLAGS += -s -w -X github.com/Ankr-network/ankrscan-utils/pkg/buildinfo.version=${VERSION} -X github.com/Ankr-network/ankrscan-utils/pkg/buildinfo.commitHash=${COMMIT_HASH} -X github.com/Ankr-network/ankrscan-utils/pkg/buildinfo.buildDate=${BUILD_DATE}

.PHONY: build
build:
	go build ${GOARGS} -tags "${GOTAGS}" -ldflags "${LDFLAGS}" -o ${BUILD_DIR}/${BINARY_NAME} ${BUILD_PACKAGE}