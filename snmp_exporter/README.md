# Docker コンテナ上でSNMP Exporterのgeneratorを動かす

Dockerファイルを作れていないのでひとまずコンテナ内に入り、直接コマンドを実行する方法で生成します。

SNMP Exporterのgeneratorをビルドするためには、Go 1.17以上が必要となります。

## 各種コマンド

```
$ docker-compose up -d --build
$ docker-compose exec snmp_generator_container /bin/bash
Dockerコンテナをビルドして起動し、Dockerコンテナのシェルに入ります。

$ git clone https://github.com/prometheus/snmp_exporter.git
SNMP Exporter をgit cloneしてローカルに置きます。
$ cd snmp_exporter/generator
generatorディレクトリに移動します。

$ make generator
$ make mibs
generatorとMIBファイルを生成します。

$ cp /home/generator.yml /home/snmp_exporter/generator/ && rm /home/snmp_exporter/snmp.yml
自分で定義したgenerator.ymlをgeneratorディレクトリに移動してから既存のsnmp.ymlを削除します。


$ cd /home/snmp_exporter/generator/mibs && wget http://www.rtpro.yamaha.co.jp/RT/docs/mib/yamaha-private-mib.zip
$ unzip ./yamaha-private-mib.zip
$ cd ./yamaha-private-mib && cp ./yamaha-* ../
$ cd /home/snmp_exporter/generator/mibs/
$ cd /home/snmp_exporter/generator/
YAMAHAのプライベートMIBをダウンロードします。

$ cd /home/snmp_exporter/generator/mibs/
$ cp /home/private_mib/elecom_private_mib_v1.4.17.mib /home/snmp_exporter/generator/mibs/
$ cd /home/snmp_exporter/generator/
ElecomのプライベートMIBをダウンロードします。

$ export MIBDIRS=/home/snmp_exporter/generator/mibs

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

## プライベートMIBについて

`./private_mib/` ディレクトリ以下のプライベートMIBのファイルは以下のサイトから取得しました。

- [Elecom WAB-S1167-PS](https://www.elecom.co.jp/products/WAB-S1167-PS.html)
  - [プライベートMIB URL](./private_mib/elecom_private_mib_v1.4.17.mib)
  - [URL](https://www.elecom.co.jp/support/download/network/wireless_lan/ap/wab-s1167-ps/index.html)
- [Elecom WAB-S1775](https://www.elecom.co.jp/products/WAB-S1775.html)
  - [プライベートMIB URL](./private_mib/S1775_elecom_private_mib_v1.1.4.mib)
  - [URL](https://www.elecom.co.jp/support/download/network/wireless_lan/ap/wab-s1775/)
