#!/usr/bin/env bash
# Falha se docs/assets/ contiver output acidental do Zensical.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ASSETS="$ROOT/docs/assets"
FAILED=0

report() {
  echo "check-docs-assets: $1" >&2
  FAILED=1
}

if [[ ! -d "$ASSETS" ]]; then
  echo "check-docs-assets: OK (docs/assets ausente, rode prepare-docs.sh)"
  exit 0
fi

if find "$ASSETS" -name 'index.html' -print -quit 2>/dev/null | grep -q .; then
  report "index.html encontrado em docs/assets/ (output Zensical indevido)"
fi

if find "$ASSETS" -name 'sitemap.xml' -print -quit 2>/dev/null | grep -q .; then
  report "sitemap.xml encontrado em docs/assets/ (output Zensical indevido)"
fi

if [[ -d "$ASSETS/assets" ]]; then
  report "docs/assets/assets/ presente (output aninhado indevido)"
fi

if [[ "$FAILED" -eq 1 ]]; then
  echo "Remova o lixo de build e use: zensical build --strict --clean" >&2
  exit 1
fi

echo "check-docs-assets: OK"
