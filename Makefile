IMAGE_NAME=jcchavezs/modsecurity-wasm-filter
IMAGE_VERSION?=latest
EXTRACT_CONTAINER_NAME=$(IMAGE_NAME)-extract

build-wasm-plugin:
	sed -i 's/envoy-wasm-modsecurity-dynamic/envoy-wasm-modsecurity/' modsecurity-wasm-filter/wasmplugin/Dockerfile
	sed -i 's/envoy-wasm-modsecurity-dynamic/envoy-wasm-modsecurity/' modsecurity-wasm-filter/wasmplugin/Makefile
	docker build --platform linux/amd64 -t $(IMAGE_NAME):$(IMAGE_VERSION) -f modsecurity-wasm-filter/wasmplugin/Dockerfile modsecurity-wasm-filter/wasmplugin
	# Go back to old state
	cd modsecurity-wasm-filter/wasmplugin; git checkout .

push-wasm-plugin:
	docker push $(IMAGE_NAME):$(IMAGE_VERSION)

extract-wasm-plugin:
	@docker rm -f $(EXTRACT_CONTAINER_NAME) || true
	@docker create --rm --name $(EXTRACT_CONTAINER_NAME) $(IMAGE_NAME):$(IMAGE_VERSION) /plugin.wasm
	@mkdir ./build
	@docker cp $(EXTRACT_CONTAINER_NAME):/plugin.wasm ./build/modsecurity-filter.wasm
	@docker rm -f $(EXTRACT_CONTAINER_NAME)

