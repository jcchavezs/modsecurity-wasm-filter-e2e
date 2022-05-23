# Modsecurity WASM filter E2E

The purpose of this e2e test is to assert the functioning of the WASM plugin

## Build plugin

```bash
git submodule update --init --recursive
make build-wasm-plugin extract-wasm-plugin
```

You'll find the WASM plugin in `./build/modsecurity-filter.wasm`

## Run E2E

You will need to have [`func-e` installed](https://func-e.io/).

```bash
func-e run -c envoy-config.yaml --log-level info --component-log-level wasm:debug
./tests.sh
```
