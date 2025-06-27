# Documentação do Projeto de Iniciação Científica
Plataforma de Data Lake Open Source na Oracle Cloud Infrastructure (CDP)

Este repositório descreve, a criação de um cluster Hadoop/Spark baseado no ODP (OpenSource Data Platform) dentro da OCI.
Foram consideradas boas práticas de governança, segurança e baixo custo descritas no relatório de planejamento do projeto.

> Atenção: todos os valores sensíveis (OCIDs, endereços IP, nomes de VCN, senhas) estão representados por **placeholders**. Substitua-os antes de executar qualquer comando.

## Sumário

1. [Visão Geral](./docs/00%20-%20Visão%20Geral)
2. [Implementação na OCI](./docs/01%20-%20OCI/00-prerequisitos.md)
3. [Instalação do ODP](./docs/02%20-%20ODP/00-prerequisitos.md)
4. [Modelos e Anexos](./assets)

---

## Fluxo recomendado de leitura e execução

Para garantir a correta implantação do ambiente, siga a ordem sequencial abaixo:

1. **Leia a [Visão Geral](./docs/00%20-%20Visão%20Geral)** para compreender o contexto, objetivos e escopo do projeto.
2. **Execute todas as etapas da [Implementação na OCI](./docs/01%20-%20OCI/00-prerequisitos.md)**, incluindo:
   - Configuração de rede, segurança, máquinas virtuais e armazenamento.
   - Definição de DNS, firewall, volumes em bloco e demais recursos de infraestrutura.
   - Siga a ordem dos arquivos numerados para garantir que cada pré-requisito seja cumprido antes de avançar.
3. **Somente após concluir a preparação da infraestrutura na OCI, inicie as etapas de [Instalação do ODP](./docs/02%20-%20ODP/00-prerequisitos.md)**:
   - Instalação e configuração do Ambari, ODP Stack e serviços Hadoop/Spark.
   - Siga rigorosamente o passo a passo para garantir reprodutibilidade.
4. **Consulte os [Modelos e Anexos](./assets)** para exemplos de arquivos de configuração, scripts e outros materiais de apoio.

---

> **Importante:** Não avance para a etapa de instalação do ODP antes de concluir toda a preparação da infraestrutura na OCI. O sucesso do cluster depende do correto provisionamento e configuração dos recursos básicos.

---
