# Brand guidelines (Cdp-Docs)

Contrato de identidade visual para humanos e agentes.

## Machine contract

```yaml
path: brand/
tokens: brand/src/tokens.css
identity: brand/src/identity.json
fonts_css: brand/src/fonts.css
bridge: brand/src/theme-bridge.css
favicon: brand/src/favicon.svg
fonts_ssot: brand/fonts/
icons_ui: lucide
cdn: forbidden
second_palette: forbidden
palette_intent: cefet-mg-beamer-contrast
palette_source: beamerthemecefetmg.sty
chrome_pattern: zensical-documentation-brand-bridge
```

## Read order

1. `brand/llms.txt`
2. `brand/GUIDELINES.md` (este arquivo)
3. `brand/src/identity.json`
4. `brand/src/tokens.css`
5. `brand/src/theme-bridge.css`
6. `brand/src/fonts.css`

## Precedencia

| Rank | Fonte | Vence para |
|------|--------|------------|
| 1 | GUIDELINES.md | Regras narrativas |
| 2 | tokens.css | Valores CSS |
| 3 | identity.json | Nome e metadados |

## MUST / MUST NOT

| MUST | MUST NOT |
|------|----------|
| Tratar `brand/` como unico SSOT visual | Segunda paleta em CSS ad hoc |
| Consumir `--dc-*` ou o bridge | Hardcode hex fora de tokens.css |
| Fontes self-host | CDN de fontes |
| Lucide no chrome | Emoji como icone de UI |
| Manter contraste CEFET Beamer | Estetica blue-grey do brand TCC docs |

## Cores principais

| Token | Hex | Origem Beamer |
|-------|-----|---------------|
| header | `#1A2744` | cefetPrimary |
| accent | `#0567FA` | cefetAccent |
| paper | `#FAFBFC` | cefetBg |
| ink | `#2C3E50` | cefetText |
| dark paper | `#0F1B30` | cefetPrimaryDark |
