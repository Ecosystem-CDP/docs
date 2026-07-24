#!/usr/bin/env bash
# Prepara docs/ para Zensical: assets da raiz, brand stylesheets e favicon.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DOCS="$ROOT/docs"
ASSETS="$DOCS/assets"

sync_tree() {
  local src="$1"
  local dest="$2"
  rm -rf "$dest"
  mkdir -p "$dest"
  # Preferir cp: evita deadlock de rsync --delete sob concorrencia local.
  cp -a "$src/." "$dest/"
}

if [[ ! -d "$ROOT/assets" ]]; then
  echo "prepare-docs: ausente $ROOT/assets" >&2
  exit 1
fi

sync_tree "$ROOT/assets" "$ASSETS"

if [[ -d "$ROOT/brand" ]]; then
  mkdir -p "$DOCS/stylesheets" "$DOCS/images" "$ASSETS/fonts"
  if [[ -d "$ROOT/brand/fonts" ]]; then
    sync_tree "$ROOT/brand/fonts" "$ASSETS/fonts"
  fi
  if [[ -f "$ROOT/brand/src/fonts.css" ]]; then
    cp -f "$ROOT/brand/src/fonts.css" "$DOCS/stylesheets/brand-fonts.css"
  fi
  if [[ -f "$ROOT/brand/src/tokens.css" && -f "$ROOT/brand/src/theme-bridge.css" ]]; then
    cat "$ROOT/brand/src/tokens.css" "$ROOT/brand/src/theme-bridge.css" \
      >"$DOCS/stylesheets/brand-bridge.css"
  fi
  if [[ -f "$ROOT/brand/src/favicon.svg" ]]; then
    cp -f "$ROOT/brand/src/favicon.svg" "$DOCS/images/favicon.svg"
  fi
fi

echo "prepare-docs: OK"
