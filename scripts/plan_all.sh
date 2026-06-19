#!/usr/bin/env bash
set -euo pipefail

for d in 00-entra-org 10-network 20-aks 30-aks-rbac; do
  echo "============================================================"
  echo "PLAN: $d"
  echo "============================================================"
  (cd "$d" && terraform init && terraform validate && terraform plan -out tfplan)
done
