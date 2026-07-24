#!/usr/bin/env bash
# Verifica se alvos relativos .md referenciados em docs/ existem.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

python3 <<'PY'
import re
import sys
from pathlib import Path
from urllib.parse import unquote

root = Path("docs")
pat = re.compile(r"\[([^\]]+)\]\(([^)]+)\)")
missing = []

for path in sorted(root.rglob("*.md")):
    text = path.read_text(encoding="utf-8")
    in_fence = False
    for i, line in enumerate(text.splitlines(), 1):
        if line.strip().startswith("```"):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        for m in pat.finditer(line):
            href = m.group(2).strip()
            if href.startswith(("http://", "https://", "mailto:", "#")):
                continue
            target = unquote(href.split("#", 1)[0].split("?", 1)[0])
            if not target:
                continue
            if not target.endswith((".md", "/")) and "." in Path(target).name:
                continue
            resolved = (path.parent / target).resolve()
            try:
                resolved.relative_to(root.resolve())
            except ValueError:
                continue
            if target.endswith("/"):
                if not resolved.is_dir():
                    missing.append(f"{path}:{i}: {href}")
            elif target.endswith(".md"):
                if not resolved.is_file():
                    missing.append(f"{path}:{i}: {href}")

if missing:
    print("== links relativos .md ausentes ==")
    print("\n".join(missing))
    print("check-doc-links: FALHOU")
    sys.exit(1)

print("check-doc-links: OK")
PY
