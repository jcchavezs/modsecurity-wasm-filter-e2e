#!/bin/bash

# This script ensures that:
# - metallb is running
# - metallb provided an EXTERNAL_IP to the ingress 

step=1
total_steps=2
max_retries=30 # timeout (seconds)

# Testing metallb pods
echo "[$step/$total_steps] Warmup - Waiting for metallb"
ready_counter=0
while [[ "$ready_counter" -ne 2 ]]; do
  ready_counter=$(kubectl get pods -n metallb-system | grep -ow '1/1' | wc -l)
  sleep 1
  echo -ne "[Wait] Waiting... $ready_counter/2 metallb pods running. Timeout: ${max_retries}s   \r"
  ((max_retries-=1))
  if [[ "$max_retries" -eq 0 ]] ; then
    echo "[Fail] Timeout waiting for metallb pods"
    exit 1
  fi
done
echo -e "\n[Ok] $ready_counter/2 metallb pods running"

# Checking if the ingress external IP is not anymore in pending status
((step+=1))
echo "[$step/$total_steps] Warmup - Checking istio-ingressgateway EXTERNAL_IP status"
INGRESS_IP=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
if [[ -z "$INGRESS_IP" ]] ; then
  echo "[Fail] EXTERNAL_IP not provided"
  exit 1
fi
echo "[Ok] istio-ingressgateway IP: $INGRESS_IP"

echo "[Done] Warmup Completed"
