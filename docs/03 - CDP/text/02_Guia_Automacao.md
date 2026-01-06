# 02 - Guia Técnico de Automação

Este documento detalha o funcionamento técnico da automação do cluster Ambari.

## 🛠️ Tecnologias Utilizadas

### 1. Terraform
O Terraform é o orquestrador principal. Ele não apenas cria as máquinas na OCI, mas também prepara o ambiente para a configuração:
*   **Provisionamento de Arquivos**: Envia `blueprint.json`, playbooks do Ansible e configurações para o `/root` do Master.
*   **User Data**: Injeta scripts de inicialização que disparam o Ansible.

### 2. Ansible
O Ansible assume a configuração após o boot da máquina.
*   **Role**: Instalação de pacotes (Java, PostgreSQL, Ambari).
*   **Templates**: Configuração dinâmica de arquivos como `ambari-agent.ini`.
*   **Orquestração**: Aguarda que todos os nós estejam online antes de iniciar a instalação do cluster.

### 3. Ambari Blueprint & API
A "mágica" acontece via API REST do Ambari. Em vez de clicar na interface ("Install Wizard"), usamos chamadas HTTP (`curl`) para:
1.  **Registrar Blueprint**: Envia o JSON que define a topologia do cluster.
2.  **Criar Cluster**: Envia o JSON de mapeamento de hosts (`cluster-template.json`) ligando FQDNs aos grupos de hosts.

---

## 🧩 Estrutura do Blueprint

O arquivo `blueprint.json` define **O QUE** será instalado. Ele é dividido em:

*   **Blueprints**: Metadados (nome, stack).
*   **configurations**: Ajustes finos de serviços (ex: `core-site`, `hdfs-site`, `hive-site`).
    *   *Nota*: Configurações de banco de dados (JDBC) e memória são definidas aqui.
*   **host_groups**: Agrupamentos lógicos de componentes.
    *   Example: `host_group_1` contém NameNode, ResourceManager, Ambari Server.
    *   Example: `host_group_2` contém DataNode, NodeManager.

## 🗺️ Mapeamento de Hosts (Cluster Template)

O arquivo `cluster-template.json` define **ONDE** será instalado. Ele mapeia os `host_groups` do blueprint para os FQDNs reais das máquinas provisionadas.

```json
{
  "blueprint": "odp-blueprint",
  "default_password": "AmbariPassword123!",
  "host_groups": [
    {
      "name": "host_group_1",
      "hosts": [ { "fqdn": "master.cdp" } ]
    },
    {
      "name": "host_group_2",
      "hosts": [
        { "fqdn": "node1.cdp" },
        { "fqdn": "node2.cdp" },
        { "fqdn": "node3.cdp" }
      ]
    }
  ]
}
```

---

## 🔄 Fluxo de Scripts de Deploy

Se precisar executar manualmente partes da automação, entenda a sequência dos scripts (localizados em `/root` no Master):

1.  **`manual_service_init.sh`**:
    *   Inicializa o banco de dados PostgreSQL.
    *   Configura o Ambari Server (`ambari-server setup`).
    *   Inicia o Ambari Server e o Agent.

2.  **`blueprint_upload.sh` (ou via Ansible)**:
    *   Registra o arquivo VDF (Version Definition File).
    *   Faz POST do `blueprint.json` para a API.

3.  **`cluster_create.sh` (ou via Ansible)**:
    *   Verifica se todos os hosts (`master`, `node1-3`) estão registrados no Ambari.
    *   Faz POST do `cluster-template.json` para iniciar a instalação.

---

## ⚠️ Pontos de Atenção

*   **Tempo de Propagação**: Após o comando de criação do cluster, o Ambari leva alguns segundos para começar a reportar progresso.
*   **Erros Comuns**:
    *   *Hosts não registrados*: Verifique o `ambari-agent.log` nos workers. O hostname deve resolver corretamente (`/etc/hosts`).
    *   *Banco de Dados Hive/Oozie*: Verifique se o PostgreSQL aceita conexões e se as senhas no blueprint batem com as do banco.
