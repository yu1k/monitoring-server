# monitoring-server

[![Config generator for SNMP Exporter](https://github.com/yu1k/monitoring-server/actions/workflows/config_file_generator_for_snmp_exporter.yml/badge.svg)](https://github.com/yu1k/monitoring-server/actions/workflows/config_file_generator_for_snmp_exporter.yml)

## node_exporter を動かす

### 監視対象ホストでの準備

#### docker-compose を利用して起動

- 監視対象ホストの環境
  - OS(cat /etc/os-release): 20.04.4 LTS (Focal Fossa)
  - シェル(echo $SHELL): bash
  - docker -v: Docker version 20.10.7, build 20.10.7-0ubuntu5~20.04.2
  - docker-compose -v: docker-compose version 1.25.0

```
$ git clone https://github.com/yu1k/monitoring-server.git monitoring-server && cd $_/node_exporter_template
$ docker-compose up -d
```

監視対象ホストで上記コマンドを実行し、 node_exporter を起動させる。監視対象ホストの `http://hostname:9100` にアクセスするとメトリクスを取れているか確認できます。

#### シェルスクリプト を実行して起動

- 監視対象ホストの環境
  - OS(cat /etc/os-release): 20.04.4 LTS (Focal Fossa)
  - シェル(echo $SHELL): bash

```
$ git clone https://github.com/yu1k/monitoring-server.git monitoring-server && cd $_/node_exporter_template
$ chmod +x ./setup-node-exporter.sh && ./setup-node-exporter.sh

$ ps
> node_exporter が起動しているか確認する
```
