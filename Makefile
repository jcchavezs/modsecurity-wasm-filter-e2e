build-wasm-plugin:
	sed -i 's/envoy-wasm-modsecurity-dynamic/envoy-wasm-modsecurity/' modsecurity-wasm-filter/wasmplugin/Dockerfile
	sed -i 's/envoy-wasm-modsecurity-dynamic/envoy-wasm-modsecurity/' modsecurity-wasm-filter/wasmplugin/Makefile
	docker build -t jcchavezs/modsecurity-wasm-filter:latest -f modsecurity-wasm-filter/wasmplugin/Dockerfile modsecurity-wasm-filter/wasmplugin
	# Go back to old state
	cd modsecurity-wasm-filter/wasmplugin; git checkout .

extract-wasm-plugin:
	docker rm -f modsecurity-wasm-filter-extract || true
	@docker create --rm --name modsecurity-wasm-filter-extract jcchavezs/modsecurity-wasm-filter:latest /plugin.wasm
	@mkdir ./build
	@docker cp modsecurity-wasm-filter-extract:/plugin.wasm ./build/modsecurity-filter.wasm
	@docker rm -f modsecurity-wasm-filter-extract

