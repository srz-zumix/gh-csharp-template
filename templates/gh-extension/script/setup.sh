#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" &>/dev/null && pwd -P)
ROOT_DIR=$(cd "${SCRIPT_DIR}/../" &>/dev/null && pwd -P)

chmod +x "${ROOT_DIR}/GhCSharpExtension"
