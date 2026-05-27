# Documentação PIBIC — Data Lake CDP na OCI

Plataforma de **Data Lake open source** na **Oracle Cloud Infrastructure (OCI)**, com cluster **Hadoop/Spark (ODP)** gerido pelo **Apache Ambari**.

**Site publicado:** [https://ecosystem-cdp.github.io/docs/](https://ecosystem-cdp.github.io/docs/)

> Atenção: valores sensíveis (OCIDs, IPs, VCN, senhas) aparecem como **placeholders** nos guias. Substitua-os antes de executar comandos.

## Estrutura do repositório

| Pasta | Conteúdo |
|-------|----------|
| [`docs/`](docs/) | Documentação PIBIC em Markdown (fonte editorial) |
| [`assets/`](assets/) | Imagens e ficheiros de apoio referenciados pelos guias |
| [`hugo.toml`](hugo.toml) | Configuração do site (Lotus Docs + mounts) |
| [`data/landing.yaml`](data/landing.yaml) | Página inicial do site |

A documentação em `docs/` é montada em `content/docs` no build Hugo **sem alterar** o texto dos guias existentes.

## Desenvolvimento local

**Requisitos:** [Hugo Extended](https://gohugo.io/installation/) ≥ 0.140.0, [Go](https://go.dev/dl/) ≥ 1.21

```bash
hugo mod get
hugo server -D
```

Abra [http://localhost:1313/docs/](http://localhost:1313/docs/).

Build de produção (mesma URL base do GitHub Pages):

```bash
hugo --gc --minify
```

## Publicação (GitHub Pages)

O workflow [`.github/workflows/deploy-docs.yml`](.github/workflows/deploy-docs.yml) faz deploy automático no push para `main`.

**Configuração única no GitHub:** *Settings → Pages → Build and deployment → Source:* **GitHub Actions**.

## Navegação rápida

1. [Visão geral do projeto](docs/00%20-%20Visão%20Geral/00-projeto.md)
2. [Implantação automatizada (CDP)](docs/03%20-%20CDP/01-resumo-executivo.md) — **recomendado**
3. [Infraestrutura OCI (manual)](docs/01%20-%20OCI/00-prerequisitos.md)
4. [Instalação ODP (manual)](docs/02%20-%20ODP/00-prérequisitos.md)

## Repositórios relacionados

- [infra-terraform-main](https://github.com/Ecosystem-CDP/infra-terraform-main) — código Terraform/Ansible
- [assets](https://github.com/Ecosystem-CDP/assets) — modelos e templates genéricos

---

Contato: joao.duarte@aluno.cefetmg.br · Licença MIT
