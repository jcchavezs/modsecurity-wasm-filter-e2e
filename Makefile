build-wasm-plugin:
	cd modsecurity-wasm-filter/wasmplugin; sed -i 's/envoy-wasm-modsecurity-dynamic/envoy-wasm-modsecurity/' Dockerfile; sed -i 's/envoy-wasm-modsecurity-dynamic/envoy-wasm-modsecurity/' Makefile
	cd modsecurity-wasm-filter/wasmplugin; docker build -t jcchavezs/modsecurity-wasm-filter:latest -f Dockerfile .
	cd modsecurity-wasm-filter/wasmplugin; sed -i 's/envoy-wasm-modsecurity/envoy-wasm-modsecurity-dynamic/' Dockerfile; sed -i 's/envoy-wasm-modsecurity/envoy-wasm-modsecurity-dynamic/' Makefile

extract-wasm-plugin:
	docker rm -f modsecurity-wasm-filter-extract || true
	@docker create --rm --name modsecurity-wasm-filter-extract jcchavezs/modsecurity-wasm-filter:latest /plugin.wasm
	@mkdir -p ./bin
	@docker cp modsecurity-wasm-filter-extract:/plugin.wasm ./bin/modsecurity-filter.wasm
	@docker rm -f modsecurity-wasm-filter-extract

