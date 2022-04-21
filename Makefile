build-wasm-plugin:
	cd modsecurity-wasm-filter/wasmplugin; docker build -t jcchavezs/modsecurity-wasm-filter:latest -f Dockerfile .

extract-wasm-plugin: build-wasm-plugin
	docker run --rm --name modsecurity-wasm-filter jcchavezs/modsecurity-wasm-filter:latest
	docker cp modsecurity-wasm-filter:/plugin.wasm ./bin/modsecurity-filter.wasm
	docker rm modsecurity-wasm-filter