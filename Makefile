ROOT:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

VS_SERVER_PORT=42420
VS_SERVER_ROOT=/opt/vintagestory
VS_SERVER_DATA=/var/vintagestory/data

, := ,

.PHONY: run
run: build
	@mkdir -p $(ROOT)/data
	@$(call wrapper, \
		sudo docker run \
			-it --rm --network host \
			--user $$(id -u):$$(id -g) \
			--env VS_SERVER_PORT=$(VS_SERVER_PORT) \
			--env VS_SERVER_DATA=$(VS_SERVER_DATA) \
			--env VS_SERVER_ROOT=$(VS_SERVER_ROOT) \
			--mount type=bind$(,)source=$(ROOT)/data$(,)target=$(VS_SERVER_DATA) \
			-t vs-server:latest \
	)

.PHONY: build
build:
	@sudo docker build \
		--build-arg VS_SERVER_PORT=$(VS_SERVER_PORT) \
		--build-arg VS_SERVER_DATA=$(VS_SERVER_DATA) \
		--build-arg VS_SERVER_ROOT=$(VS_SERVER_ROOT) \
		-t vs-server:latest $(ROOT)

define wrapper
	@$(ROOT)/wrapper.sh $(1)
endef
