#!/usr/bin/env python3
"""Validate Hugo public build for common documentation regressions."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


ATTR_RE = re.compile(r"""(?:href|src)=["']([^"']+)["']""", re.IGNORECASE)


def expected_public_target(public_dir: Path, value: str, site_prefix: str) -> Path | None:
    """Map a site-internal /docs/* URL to a file path in public/."""
    clean = value.split("#", 1)[0].split("?", 1)[0]
    if not clean.startswith(site_prefix):
        return None

    rel = clean[len(site_prefix) :].lstrip("/")
    target = public_dir / rel

    if clean.endswith("/"):
        return target / "index.html"
    if target.suffix:
        return target
    return target / "index.html"


def validate(public_dir: Path, site_prefix: str) -> list[str]:
    errors: list[str] = []
    html_files = sorted(public_dir.rglob("*.html"))

    if not html_files:
        return [f"Nenhum arquivo HTML encontrado em {public_dir}"]

    for html_file in html_files:
        content = html_file.read_text(encoding="utf-8", errors="ignore")
        rel_html = html_file.relative_to(public_dir)

        if "/docs/docs/" in content:
            errors.append(f"{rel_html}: contém URL duplicada '/docs/docs/'")

        for ref in ATTR_RE.findall(content):
            if ref.startswith(("http://", "https://", "mailto:", "tel:", "#")):
                continue
            if ref.startswith(("javascript:", "data:")):
                continue
            if ".md" in ref:
                errors.append(f"{rel_html}: referência a markdown cru: {ref}")
                continue

            if ref.startswith(site_prefix):
                target = expected_public_target(public_dir, ref, site_prefix)
                if target and not target.exists():
                    errors.append(f"{rel_html}: link interno quebrado {ref} -> {target.relative_to(public_dir)}")
                continue

            if ref.startswith("/"):
                # Other absolute paths are outside this docs site prefix.
                continue

            # Relative refs
            rel_target = (html_file.parent / ref).resolve()
            if not rel_target.exists():
                errors.append(f"{rel_html}: referência relativa quebrada {ref}")

    required_pages = [
        public_dir / "index.html",
        public_dir / "00---visão-geral" / "index.html",
        public_dir / "01---oci" / "index.html",
        public_dir / "02---odp" / "index.html",
        public_dir / "03---cdp" / "index.html",
    ]
    for required in required_pages:
        if not required.exists():
            errors.append(f"Página obrigatória ausente: {required.relative_to(public_dir)}")

    return errors


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--public-dir", default="public", help="Diretório de saída do Hugo")
    parser.add_argument("--site-prefix", default="/docs/", help="Prefixo público do site")
    args = parser.parse_args()

    public_dir = Path(args.public_dir).resolve()
    if not public_dir.exists():
        print(f"Diretório não encontrado: {public_dir}", file=sys.stderr)
        return 2

    errors = validate(public_dir, args.site_prefix)
    if errors:
        print("Falhas de validação detectadas:")
        for err in errors:
            print(f"- {err}")
        return 1

    print("Validação do build concluída sem erros.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
