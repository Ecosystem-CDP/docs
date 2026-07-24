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

O site publico e [https://ecosystem-cdp.github.io/docs/](https://ecosystem-cdp.github.io/docs/).

1. Em `Ecosystem-CDP/docs` → Settings → Pages → Build and deployment → Source = **GitHub Actions**.
2. Nao usar Deploy from a branch (isso publica o README e sobrescreve o Zensical).
3. O workflow `.github/workflows/deploy-docs.yml` faz prepare, gates, `zensical build --strict --clean`, `.nojekyll` e deploy do artifact `public/`.
4. O `README.md` e so para o repositorio GitHub. A homepage do site vem de `docs/index.md`.

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
