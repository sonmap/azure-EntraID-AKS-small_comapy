#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
zip -r ../terraform-root.zip . -x "**/.terraform/*" "**/tfplan" "**/.terraform.lock.hcl"
