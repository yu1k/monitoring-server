# monitoring-server

## 使い方

### 監視対象ホストでの準備

```
$ git clone https://github.com/yu1k/monitoring-server.git monitoring-server && cd $_/node_exporter_template
$ docker-compose up -d
```

監視対象ホストで上記コマンドを実行し、 node_exporter を起動させる。監視対象ホストの `http://hostname:9100` にアクセスするとメトリクスを取れているか確認できます。
