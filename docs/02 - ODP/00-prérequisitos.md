# 00 -  Pré-requisitos

Este documento descreve todos os requisitos mínimos — de infraestrutura, software e acesso — para que a instalação da OpenSource Data Platform (ODP) 1.2.4.0 seja feita em qualquer ambiente Oracle Cloud Infrastructure (OCI) ou em servidores bare-metal compatíveis, usando **Oracle Linux 9** em **arquitetura ARM64**.

Nos tópicos 1, 2, 3 e 4 abaixo há informações gerais de revisão e recomendações. É importante confirmar que suas máquinas atendem aos requisitos de hardware e consultar as documentações oficiais da Clemlab e da OCI para mais detalhes.

***

## 1. Infra-estrutura mínima

A seguir, a configuração de referência em OCI para cada nó:

| Papel do nó | OCPU mín. | Memória mín. | Shape OCI               | Armazenamento |
|-------------|-----------|--------------|-------------------------|---------------|
| master      | 1 OCPU    | 6 GiB        | VM.Standard.A1.Flex     | 50 GiB        |
| node × 3    | 1 OCPU    | 6 GiB        | VM.Standard.A1.Flex     | 50 GiB        |

> Obs.: Ajuste OCPU e RAM conforme carga de trabalho. Em bare-metal, considere configurações equivalentes.

***

## 2. Rede e DNS

| Item                              | Valor                               |
|-----------------------------------|-------------------------------------|
| VCN CIDR                          | `<CIDR_VCN>` (ex.: 10.0.0.0/16)     |
| Subnet pública CIDR               | `<CIDR_PUBLICA>` (ex.: 10.0.1.0/24) |
| Subnet privada CIDR (dados)       | `<CIDR_PRIVADA>` (ex.: 10.0.2.0/24) |
| Security List / NSG – portas IN   | 22/tcp, 8080/tcp, 8440-8441/tcp     |
| Security List / NSG – portas OUT  | 80/tcp, 443/tcp                     |
| DNS interno                       | `<dominio_local>` (ex.: cdp.dev.br) |

***

## 3. Acesso à Internet ou repositório offline

A instalação pode ser feita de duas formas:

1. **Online:** permitindo saída HTTP/HTTPS (80/443) para `archive.clemlab.com`.
2. **Offline:** baixando previamente:
   - `repos-ambari.tar.gz`
   - `repos.tar.gz`
   - `repos-utils.tar.gz`

Em cenários offline, copie os arquivos para `/opt/odp-repo/` em **todos** os nós e aponte o DNF para o caminho local.

***

## 4. Usuários, chaves e permissões

- **Usuário padrão do SO:** `opc`, com privilégio sudo.
- **SSH:** chave RSA/ECDSA carregada no OCI ou distribuída manualmente (`~/.ssh/id_rsa`).
- **Fuso horário e NTP:** serviço chronyd habilitado e sincronizado.

***

## 5. Dependências do sistema operacional

> Todos os comandos devem ser executados em **todos** os nós (master e workers) com privilégio sudo.

### 5.1 Atualização do sistema

```bash
sudo dnf update -y
sudo reboot
```

### 5.2 Instalação de pacotes essenciais

```bash
sudo dnf install -y \
  java-1.8.0-openjdk-headless \
  java-1.8.0-openjdk-devel \
  python3 python3-pip \
  curl wget tar unzip \
  net-tools bind-utils \
  openssh-server openssh-clients \
  chrony libaio psmisc rsync which
```

### 5.3 Ajustes de kernel e memória

Crie `/etc/sysctl.d/99-odp.conf` com:

```text
# — Desempenho e estabilidade para Hadoop / Spark —
vm.swappiness                 = 1
vm.overcommit_memory          = 1
vm.max_map_count              = 262144

# Buffers de rede
net.core.somaxconn            = 1024
net.core.netdev_max_backlog   = 5000
net.ipv4.tcp_tw_reuse         = 1
net.ipv4.ip_local_port_range  = 10240 65535
```

```bash
sudo sysctl --system
```

### 5.4 Limites de arquivos e processos

Crie `/etc/security/limits.d/99-odp.conf`:

```text
* soft  nofile 65536
* hard  nofile 65536
* soft  nproc  65536
* hard  nproc  65536
```

Verifique PAM:

```bash
grep -q pam_limits.so /etc/pam.d/system-auth \
  || echo "session required pam_limits.so" \
       | sudo tee -a /etc/pam.d/system-auth
```

***

## 6. Sincronização de tempo

```bash
sudo systemctl enable --now chronyd
chronyc sources -v
timedatectl status
```

***

## 7. Portas e firewall

Em cada nó, abra portas com **firewalld**:

```bash
sudo firewall-cmd --permanent --add-port=22/tcp
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --permanent --add-port=8440-8441/tcp
sudo firewall-cmd --permanent --add-port=50070/tcp
sudo firewall-cmd --permanent --add-port=8088/tcp
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
```

***

## 8. Definição de hostname

Em cada nó, ajuste o hostname:

```bash
# Master
sudo hostnamectl set-hostname master.cdp.dev.br

# Node1
sudo hostnamectl set-hostname node1.cdp.dev.br

# Node2
sudo hostnamectl set-hostname node2.cdp.dev.br

# Node3
sudo hostnamectl set-hostname node3.cdp.dev.br

sudo reboot
```

***

## 9. Configuração de DNS interno (/etc/hosts)

Edite `/etc/hosts` em **todos** os nós:

```text
150.230.68.97   master.cdp.dev.br master-cdp
167.234.244.116 node1.cdp.dev.br  node1-cdp
150.230.79.249  node2.cdp.dev.br  node2-cdp
152.70.219.228  node3.cdp.dev.br  node3-cdp
```

Verifique:

```bash
hostname -f
ping -c2 master-cdp devnull
ping -c2 node1-cdp
```

***

## 10. SSH sem senha (passwordless SSH)

No **master**, gere e distribua chaves:

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
for host in master-cdp node1-cdp node2-cdp node3-cdp; do
  ssh-copy-id opc@"${host}.cdp.dev.br"
done
```

Teste:

```bash
ssh opc@node1-cdp.cdp.dev.br hostname -f
```

***

## 11. Limpeza e cache do DNF

```bash
sudo dnf clean all
sudo dnf makecache
```

Teste acesso aos repositórios Clemlab:

```bash
curl -I https://archive.clemlab.com/centos9-aarch64/
```

***

Após concluir estes pré-requisitos, prossiga para `01-configuracao-repositorio.md`, onde será configurado o repositório ODP e iniciada a instalação do Ambari.