## Configuração do Repositório ODP

1. Importe a chave GPG:
```bash
wget -O - https://archive.clemlab.com/RPM-GPG-KEY-Jenkins
| gpg --dearmor
| sudo tee /etc/apt/trusted.gpg.d/odp.gpg > /dev/null
```

2. Adicione o repositório:

```bash
echo "deb [signed-by=/etc/apt/trusted.gpg.d/odp.gpg] \
https://archive.clemlab.com/ubuntu22/odp-release/1.2.4.0-108/ ./" \
| sudo tee /etc/apt/sources.list.d/odp.list
```

3. Atualize o cache:

```bash
sudo apt update
```
Obs: Caso receba **403 Forbidden**, consulte *02-odp/99-problemas-conhecidos.md* para soluções alternativas (uso de `repos.tar.gz`, proxy corporativo etc.).