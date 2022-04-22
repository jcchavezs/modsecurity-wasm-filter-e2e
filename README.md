# Modsecurity WASM filter E2E

The purpose of this e2e test is to assert the functioning of the WASM plugin

## Build plugin

```bash
make build-wasm-plugin extract-wasm-plugin
```

You'll find the WASM plugin in `./bin/modsecurity-filter.wasm`

## Run E2E

```bash
docker run --rm -d -p 8000:10080 jcchavezs/httpmole
func-e run -c envoy-config.yaml --log-level info --component-log-level wasm:trace
curl -i localhost:8001/admin
```
