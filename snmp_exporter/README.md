# Docker コンテナ上でSNMP Exporterのgeneratorを動かす

Dockerファイルを作れていないのでひとまずコンテナ内に入り、直接コマンドを実行する方法で生成します。

SNMP Exporterのgeneratorをビルドするためには、Go 1.17以上が必要とります。

## 各種コマンド

```
$ docker-compose up -d --build
$ docker-compose exec /bin/bash
Dockerコンテナをビルドして起動し、Dockerコンテナのシェルに入ります。

$ git clone https://github.com/prometheus/snmp_exporter.git
SNMP Exporter をgit cloneしてローカルに置きます。
$ cd snmp_exporter/generator
generatorディレクトリに移動します。

$ make generator
$ make mibs
generatorとMIBファイルを生成します。

$ cp /home/generator.yml /home/snmp_exporter/generator/ && rm /home/snmp_exporter/generator/snmp.yml
自分で定義したgenerator.ymlをgeneratorディレクトリに移動してから既存のsnmp.ymlを削除します。


$ cd /home/snmp_exporter/generator/mibs && wget http://www.rtpro.yamaha.co.jp/RT/docs/mib/yamaha-private-mib.zip
$ unzip ./yamaha-private-mib.zip
$ cd ./yamaha-private-mib && cp ./yamaha-* ../
$ cd /home/snmp_exporter/generator/mibs/
$ cd /home/snmp_exporter/generator/
YAMAHAのプライベートMIBをダウンロードします。

$ cd /home/snmp_exporter/generator/mibs/
$ cp /home/private_mib/WAB-S1167-PS-FW-V1-5-6/elecom_private_mib_v1.4.17.mib /home/snmp_exporter/generator/mibs/
$ cd /home/snmp_exporter/generator/
ElecomのプライベートMIBをダウンロードします。

make generate
generator.ymlの定義に従ってsnmp.ymlを生成します。

$ rm /home/snmp.yml && cp /home/snmp_exporter/generator/snmp.yml /home/
以前作成したsnmp.ymlを削除し、新しいsnmp.ymlを/home以下に移動します。
```

## そのほか

```
$ sudo chmod 777 ./snmp_exporter/generator/generator.yml
コンテナ内のgenerator.ymlをホスト側で編集できるように権限をつけます。
```
