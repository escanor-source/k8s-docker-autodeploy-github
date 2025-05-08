#!/bin/bash

echo "[INFO] Installing kubectl..."
curl -LO https://dl.k8s.io/release/v1.30.0/bin/linux/arm64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

NAMESPACE=${1:-client-escanor-source}

echo "[INFO] Creating namespace '$NAMESPACE' if it doesn't exist..."
kubectl get namespace $NAMESPACE >/dev/null 2>&1 || kubectl create namespace $NAMESPACE

echo "[INFO] Applying deployment and service..."
kubectl apply -n $NAMESPACE -f deployment.yaml
kubectl apply -n $NAMESPACE -f service.yaml

echo "[DONE] Namespace, deployment en service zijn ingesteld."
