# monitoring-server

[![Config generator for SNMP Exporter](https://github.com/yu1k/monitoring-server/actions/workflows/config_file_generator_for_snmp_exporter.yml/badge.svg)](https://github.com/yu1k/monitoring-server/actions/workflows/config_file_generator_for_snmp_exporter.yml)

監視サーバ等の設定ファイルです。

## 環境

  - OS(cat /etc/os-release): 20.04.4 LTS (Focal Fossa)
  - シェル(echo $SHELL): bash
  - docker -v: Docker version 20.10.7, build 20.10.7-0ubuntu5~20.04.2
  - docker-compose -v: docker-compose version 1.25.0

## 動かし方

```
$ git clone https://github.com/yu1k/monitoring-server.git monitoring-server && cd $_

$ docker network create --driver=bridge --subnet=172.20.0.0/24 br_prom_network --attachable -o com.docker.network.bridge.name="br_prom_network"

$ docker-compose up -d
すべてのサービスを起動させます。
```

上記コマンドを実行して監視サーバ等のDockerコンテナを起動します。

監視サーバのコンテナを動かしているホストのeth0が所属しているVLANのサブネットと監視サーバのコンテナが所属しているDockerネットワークのサブネットが重複してしまうことを防ぐため、br_prom_networkというDockerネットワークを作成します。br_prom_networkの `--subnet` のパラメータは環境に応じて適当に変更します。

```
$ docker-compose down --rmi local
起動したコンテナを停止し、コンテナ、ネットワーク、ボリューム、イメージ等の関連するリソースを削除します。

$ docker-compose restart [container_name]
指定したコンテナを再起動します。
```

上記コマンドを実行してコンテナを操作します。

## 監視対象で node_exporter を動かします。

### 監視対象ホストでの準備

#### docker-compose を利用して起動

- 監視対象ホストの環境
  - OS(cat /etc/os-release): 20.04.4 LTS (Focal Fossa)
  - シェル(echo $SHELL): bash
  - docker -v: Docker version 20.10.7, build 20.10.7-0ubuntu5~20.04.2
  - docker-compose -v: docker-compose version 1.25.0

```
$ git clone https://github.com/yu1k/monitoring-server.git monitoring-server && cd $_/node_exporter_template

$ docker network create --driver=bridge --subnet=172.20.0.0/24 br_prom_network --attachable -o com.docker.network.bridge.name="br_prom_network"

$ docker-compose up -d
```

監視対象ホストで上記コマンドを実行し、br_prom_networkというDockerネットワークを作成して node_exporterを起動させる。監視対象ホストの `http://hostname:9100` にアクセスするとメトリクスを取れているか確認できます。

node_exporterコンテナを動かしているホストのeth0が所属しているVLANのサブネットとnode_exporterが所属しているDockerネットワークのサブネットが重複してしまうことを防ぐため、br_prom_networkというDockerネットワークを作成します。br_prom_networkの `--subnet` のパラメータは環境に応じて適当に変更します。

#### シェルスクリプト を実行して起動します。

- 監視対象ホストの環境
  - OS(cat /etc/os-release): 20.04.4 LTS (Focal Fossa)
  - シェル(echo $SHELL): bash

```
$ git clone https://github.com/yu1k/monitoring-server.git monitoring-server && cd $_/node_exporter_template
$ chmod +x ./setup-node-exporter.sh && ./setup-node-exporter.sh

$ ps
> node_exporter が起動しているか確認します。
```

## エラーが発生した場合

```
$ docker-compose logs --tail 25 --follow --timestamps [container_name]
指定したDockerコンテナのログを吐き出して、Google検索等で検索しながら気合いで調査します。上のコマンドではログファイルの後ろから25件のログを吐き出しています。

$ docker-compose up -d [container_name]
指定したコンテナを再度起動します。
```
