# monitoring-server

## 使い方

### 監視対象ホストでの準備

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
