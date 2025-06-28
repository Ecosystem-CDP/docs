# 00 • Pré-requisitos para OCI

## 1. Criação da conta
Inicialmente, acesse este link e crie uma conta do tipo free tier. Dessa forma, será capaz de utilizar os recursos da Oracle cloud com um crédito base de $300,00. [Link de acesso](https://www.oracle.com/cloud/free/).

> É interessante que mesmo com este crédito, também adicione um cartão de crédito à conta, mesmo que não seja utilizado. Ocorre que alguns recuros de hardware, como a máquina que será utilizada, em termos de quantidade de instâncias, são limitadas.

## 2. Sequência de Procedimentos para Preparação do Ambiente na OCI

A tabela abaixo apresenta, em ordem lógica e sequencial, os principais passos para preparar o ambiente na Oracle Cloud Infrastructure (OCI) antes da criação das instâncias que comporão o cluster Hadoop/ODP/Ambari.

| Etapa | Descrição | Observações Importantes |
|-------|-----------|------------------------|
| 1     | Criar Compartimento (Compartment) | Organize recursos do projeto em um compartimento dedicado. |
| 2     | Criar Rede Virtual (VCN) | Defina um bloco CIDR adequado (ex: 10.0.0.0/16). |
| 3     | Criar Sub-rede Pública | Para acesso SSH e Ambari Web; exemplo: 10.0.1.0/24. |
| 4     | Criar Sub-rede Privada (opcional) | Para dados internos do cluster, se desejar isolar tráfego. |
| 5     | Criar Gateway de Internet | Necessário para acesso externo/SSH. |
| 6     | Criar Gateway NAT (opcional) | Permite que sub-redes privadas acessem a internet. |
| 7     | Criar Tabela de Rotas | Associe rotas para internet/NAT às sub-redes correspondentes. |
| 8     | Criar Security List (Lista de Segurança) | Libere portas 22 (SSH), 8080 (Ambari), 8440-8441 (Ambari Agent), 80/443 (atualizações). |
| 9     | Criar Network Security Groups (NSG) | Permite regras de firewall mais flexíveis por aplicação. |
| 10    | Associar Security List e NSG às sub-redes | Garanta que as regras estejam ativas para as VMs. |
| 11    | Criar Par de Chaves SSH | Geração local para acesso seguro às instâncias. |
| 12    | (Opcional) Criar Block Volumes | Para armazenamento de dados HDFS/Hive em cada VM. |
| 13    | Revisar Limites de Quotas | Verifique se há recursos suficientes para criar todas as VMs necessárias. |
| 14    | Criar Instâncias de Computação (VMs) | Master, node1, node2, node3, com Ubuntu 22.04. |
| 15    | Anexar Volumes em Bloco às VMs | Para dados do cluster, se necessário. |
| 16    | Validar Acesso SSH e Configuração de Rede | Teste conectividade e resolução de nomes entre as VMs. |

---
> **Importante:** Execute cada etapa sequencialmente, validando o funcionamento antes de prosseguir. Estarei utilizando valores genéricos nos exemplos (CIDR, nomes, IPs), portanto é necessário que substitua posteriormente por dados do seu cluster.
---




