# 03 – Instalação e Configuração de componentes após Base
## Correções por componente
HDFS: Basta ativar o componente
YARN: Execute os comandos abaixo antes de iniciar o componente:

```shell
# 1) garantir diretório de destino no HDFS
sudo -u hdfs /usr/odp/1.2.2.0-128/hadoop/bin/hdfs dfs -mkdir -p /odp/apps/1.2.2.0-128/hbase

# 2) enviar o pacote forçando overwrite se necessário
sudo -u hdfs /usr/odp/1.2.2.0-128/hadoop/bin/hdfs dfs -put -f \
  /var/lib/ambari-agent/tmp/yarn-ats/1.2.2.0-128/hbase.tar.gz \
  /odp/apps/1.2.2.0-128/hbase/

# 3) ajustar permissões e ownership como esperado pelo script (444 e owner hdfs)
sudo -u hdfs /usr/odp/1.2.2.0-128/hadoop/bin/hdfs dfs -chmod 444 /odp/apps/1.2.2.0-128/hbase/hbase.tar.gz
sudo -u hdfs /usr/odp/1.2.2.0-128/hadoop/bin/hdfs dfs -chown hdfs:hdfs /odp/apps/1.2.2.0-128/hbase

# 4) validar no HDFS
sudo -u hdfs /usr/odp/1.2.2.0-128/hadoop/bin/hdfs dfs -ls -h /odp/apps/1.2.2.0-128/hbase
```

HBASE: instalação pelo método padrão, o query fenix seria a master
KAFKA: também pela interface, os brokers são os nodes
