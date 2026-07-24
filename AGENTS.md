# AGENTS.md (Cdp-Docs)

Instrucoes para agentes neste repositorio (Zensical).

## Projeto

Documentacao PIBIC do Data Lake open source (ODP/Ambari) na OCI.
Narrativa em `docs/`. Brand SSOT em `brand/`. Assets estaticos na raiz `assets/`.

## Lingua

PT-BR em texto editorial.

## Build

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
bash scripts/prepare-docs.sh
zensical serve
```

Producao:

```bash
bash scripts/prepare-docs.sh
bash scripts/check-docs-assets.sh
bash scripts/check-doc-links.sh
zensical build --strict --clean
```

Site em `public/` (`site_dir` em `mkdocs.yml`). Nunca gerar o site em `docs/assets`.

## GitHub Pages

O site publico e [https://ecosystem-cdp.github.io/](https://ecosystem-cdp.github.io/) (raiz da org).
O codigo-fonte fica em `Ecosystem-CDP/docs`. O HTML publicado vai para `Ecosystem-CDP/ecosystem-cdp.github.io`.

1. Secret `PAGES_DEPLOY_TOKEN` no repo `docs` (PAT com `contents: write` em `ecosystem-cdp.github.io`).
2. Em `ecosystem-cdp.github.io` → Settings → Pages → Source = **Deploy from a branch** (`main`).
3. O workflow `.github/workflows/deploy-docs.yml` faz prepare, gates, `zensical build --strict --clean`, `.nojekyll` e push de `public/` para `ecosystem-cdp.github.io` (`main`).
4. O `README.md` e so para o repositorio GitHub. A homepage do site vem de `docs/index.md`.
5. `/docs/` (Pages do repo `docs`) nao e o destino canonico. Pode ser desligado depois.

## Brand

Ordem: `brand/llms.txt` depois `brand/GUIDELINES.md` depois `brand/src/`.
Tokens `--dc-*` com cores CEFET Beamer. Padrao de chrome do template Zensical.

## Tags

1. Catalogo em `mkdocs.yml` (`extra.tags`, `theme.icon.tag`).
2. Frontmatter usa rotulos do catalogo.
3. Nao inventar tags fora do catalogo.
4. Nao editar corpo MD ao so atualizar tags.

## Prioridade

1. Corpo MD intocado (exceto frontmatter aditivo)
2. Contrato Vite ausente nesta leva (sem Lit)
3. Contrato Zensical output e brand
4. Tags e links
5. Gates CI antes de concluir mudancas amplas
