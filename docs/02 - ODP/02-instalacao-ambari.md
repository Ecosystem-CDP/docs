# 02 – Instalação e Configuração Básica do Ambari

Esta etapa cobre a instalação e configuração inicial do Ambari Server e Ambari Agent, preparando o ambiente para a configuração dos serviços do cluster Hadoop/Spark via interface web.

---

## 1. Instalação dos Pacotes

Caso ainda não tenha feito na etapa anterior, faça estes passos abaixo:

### 1.1. Ambari Server (apenas no nó master)

No **nó master**, execute:
```bash
sudo apt update
sudo apt install -y ambari-server
```


### 1.2. Ambari Agent (em todos os nós)

Em **todos os nós** (incluindo o master):

```bash
sudo apt update
sudo apt install -y ambari-agent
```

---

## 2. Configuração do Ambari Server

Antes de iniciar o serviço, é necessário realizar o setup inicial, que configura o banco de dados do Ambari, o JDK e outros parâmetros essenciais.

No **nó master**:

```bash
sudo ambari-server setup
```

Durante o processo interativo, você poderá:

- Definir o caminho do JAVA_HOME (ex: `/usr/lib/jvm/java-8-openjdk-amd64`)
- Escolher o banco de dados para o Ambari (por padrão, PostgreSQL integrado)
- Aceitar ou personalizar outros parâmetros avançados

> **Dica:**
> Para automatizar o processo ou definir opções específicas, utilize os parâmetros:
> - `-j /caminho/do/java` para especificar o JAVA_HOME
> - `--jdbc-driver` e `--jdbc-db` para configurar drivers de banco externos
> - `-s` para modo silencioso (aceita todos os padrões)

---

## 3. Configuração do Ambari Agent

Em **todos os nós**, edite o arquivo de configuração do agent para apontar para o servidor master:

```bash
sudo nano /etc/ambari-agent/conf/ambari-agent.ini
```

Altere a linha para:

```bash
hostname=master.clemlab.local
```


Salve e feche o arquivo.

---

## 4. Inicialização dos Serviços

### 4.1. Ambari Server (no master)

```bash
sudo systemctl enable ambari-server
sudo systemctl start ambari-server
```


### 4.2. Ambari Agent (em todos os nós)

```bash
sudo systemctl enable ambari-agent
sudo systemctl start ambari-agent
```

---

## 5. Verificação dos Serviços

No **nó master**:
```bash
sudo systemctl status ambari-server
```

Em **todos os nós**:

```bash
sudo systemctl status ambari-agent
```

O status deve ser **active (running)**.

---

## 6. Acesso à Interface Web do Ambari

Após iniciar os serviços, aguarde alguns instantes e acesse a interface web do Ambari pelo navegador:

```bash
http://<IP_DO_MASTER>:8080
```


- **Usuário padrão:** admin
- **Senha padrão:** admin

---

## 7. Checklist antes de prosseguir

- [ ] Ambari Server instalado e configurado no master
- [ ] Ambari Agent instalado e configurado em todos os nós
- [ ] Todos os serviços ativos e rodando
- [ ] Interface web do Ambari acessível na porta 8080

---

Após concluir esta etapa, siga para o documento `03-configuracao-servicos.md` para iniciar o assistente de configuração dos serviços do cluster via Ambari.

