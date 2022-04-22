build-wasm-plugin:
	cd modsecurity-wasm-filter/wasmplugin; docker build -t jcchavezs/modsecurity-wasm-filter:latest -f Dockerfile .

extract-wasm-plugin:
	docker rm -f modsecurity-wasm-filter-extract || true
	@docker create --rm --name modsecurity-wasm-filter-extract jcchavezs/modsecurity-wasm-filter:latest /plugin.wasm
	@mkdir ./bin
	@docker cp modsecurity-wasm-filter-extract:/plugin.wasm ./bin/modsecurity-filter.wasm
	@docker rm -f modsecurity-wasm-filter-extract

