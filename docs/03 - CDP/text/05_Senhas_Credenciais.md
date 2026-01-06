# 05 - Credenciais e Senhas

Este documento registra as credenciais padrão configuradas nos scripts de automação.

> [!WARNING]
> **SEGURANÇA**: Estas senhas são para ambientes de desenvolvimento/PoC. Para produção, todas as senhas devem ser alteradas imediatamente após a instalação ou parametrizadas via Terraform/Vault.

## 🔑 Acesso ao Cluster (Ambari UI)

| Serviço | URL | Usuário | Senha Padrão |
| :--- | :--- | :--- | :--- |
| **Ambari Dashboard** | `http://<MASTER_IP>:8080` | `admin` | `admin` |

## 🔑 Serviços do Cluster

A maioria dos serviços (Hive, Ranger, Oozie) utiliza uma senha mestre definida no Blueprint.

| Função | Usuário | Senha | Notas |
| :--- | :--- | :--- | :--- |
| **Cluster Default** | (vários) | `Ambari1234` | Aplicado a Keystores e Contas de Serviço |
| **Ranger Admin** | `keyadmin` | `Ambari1234` | Login do Ranger UI |
| **Ranger Usersync** | `rangerusersync` | `Ambari1234` | |
| **Ranger Tagsync** | `rangertagsync` | `Ambari1234` | |
| **Hive DB** | `hive` | `hive` | Banco de dados Metastore (Postgres/MySQL) |

## 🖥️ Acesso à Infraestrutura (SSH)

| Máquina | Usuário | Autenticação |
| :--- | :--- | :--- |
| **Todas as VMs** | `opc` | Chave SSH Privada (definida no Terraform) |
| **Root** | `root` | `sudo -i` (sem senha a partir de `opc`) |

## 📝 Regras de Senha (Policy)
O Ambari e Ranger impõem as seguintes políticas mínimas (que o `Ambari1234` satisfaz):
*   Mínimo 8 caracteres.
*   Pelo menos 1 letra.
*   Pelo menos 1 número.
*   Proibidos caracteres especiais conflitantes com shell scripts (`"`, `'`, `\`, `` ` ``).
