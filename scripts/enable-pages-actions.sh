#!/usr/bin/env bash
# Define GitHub Pages Source = GitHub Actions no repo Ecosystem-CDP/docs.
# Requer: gh autenticado (gh auth login) com permissao admin no repo.
set -euo pipefail

OWNER="${PAGES_OWNER:-Ecosystem-CDP}"
REPO="${PAGES_REPO:-docs}"

if ! command -v gh >/dev/null 2>&1; then
  echo "enable-pages-actions: instale o GitHub CLI (gh) e rode gh auth login" >&2
  exit 1
fi

echo "enable-pages-actions: definindo build_type=workflow em ${OWNER}/${REPO}"
gh api \
  --method PUT \
  -H "Accept: application/vnd.github+json" \
  "/repos/${OWNER}/${REPO}/pages" \
  -f build_type=workflow

echo "enable-pages-actions: disparando workflow Deploy Zensical to GitHub Pages"
gh workflow run "Deploy Zensical to GitHub Pages" --repo "${OWNER}/${REPO}" || true

echo "enable-pages-actions: OK"
echo "Confirme em https://github.com/${OWNER}/${REPO}/settings/pages que Source = GitHub Actions"
echo "Site esperado: https://ecosystem-cdp.github.io/docs/"
