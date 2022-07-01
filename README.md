# monitoring-server

[![Config generator for SNMP Exporter](https://github.com/yu1k/monitoring-server/actions/workflows/config_file_generator_for_snmp_exporter.yml/badge.svg)](https://github.com/yu1k/monitoring-server/actions/workflows/config_file_generator_for_snmp_exporter.yml)

## 動かし方

```
$ docker-compose up -d --build
すべてのサービスを起動させる

$ docker-compose down --rmi local
起動したコンテナを停止し、コンテナ、ネットワーク、ボリューム、イメージ等の関連するリソースを削除する

$ docker-compose restart [container_name]
指定したコンテナを再起動する
```

## 監視対象で node_exporter を動かす

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

## エラーが発生した場合

```
$ docker-compose logs --tail 25 --follow --timestamps [container_name]
指定したDockerコンテナのログを吐き出して、Google検索等で検索しながら調査する。上のコマンドではログファイルの後ろから25件のログを吐き出しています。

$ docker-compose up --build [container_name]
指定したコンテナをビルドし直して up する

```
