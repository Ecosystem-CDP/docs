# 01 • Configuração do Repositório ODP e Instalação do Ambari/ODP

Este documento detalha o processo de configuração dos repositórios oficiais da Clemlab e a instalação dos componentes Ambari Server, Ambari Agent e ODP Stack em ambiente Ubuntu 22.04.

> **Atenção:** Os repositórios da Clemlab exigem autenticação prévia no portal para que os caminhos dos pacotes estejam acessíveis. Sempre valide seu login antes de iniciar o procedimento.

---

## 1. Importar a chave GPG

Execute em **todos os nós**:

```bash
wget -O - https://archive.clemlab.com/RPM-GPG-KEY-Jenkins | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/odp.gpg > /dev/null
```

---

## 2. Adicionar o repositório do Ambari (Python 3)

Execute em **todos os nós**:

```bash
wget -O /etc/apt/sources.list.d/ambari.list https://archive.clemlab.com/ubuntu22-python3/ambari-release/2.7.11.0.0-161/ambari.list
```
---

## 3. Adicionar o repositório do ODP Stack

Execute em **todos os nós**:

```bash
wget -O /etc/apt/sources.list.d/odp.list https://archive.clemlab.com/ubuntu22/odp-release/1.2.4.0-108/ambari.list
```
---

## 4. Atualizar o cache do APT

Execute em **todos os nós**:

```bash
sudo apt update
```
Se receber **403 Forbidden**, consulte `02-odp/99-problemas-conhecidos.md` para soluções alternativas (uso de `repos.tar.gz`, proxy corporativo, etc).
---

## 5. Instalar o Ambari Agent (em todos os nós)

```bash
sudo apt install ambari-agent
```
---

## 6. Instalar o Ambari Server (**apenas no nó master**)

No **nó master**:

```bash
sudo apt install ambari-server
```
