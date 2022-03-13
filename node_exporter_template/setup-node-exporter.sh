#!/bin/bash

set -eux

apt update && \
apt upgrade -y && \
apt install -y \
  ufw \
  curl \
  wget \
  tar \

ufw enable
ufw default deny
ufw allow 19100/tcp
ufw reload

# CPUのアーキテクチャによってダウンロードするバイナリを変える, x86_64: amd64, aarch64: aarch64
# node_exporter releases: https://github.com/prometheus/node_exporter/releases
CPU_ARCHITECTURE=`uname -m`
if echo $CPU_ARCHITECTURE | grep 'x86_64' ; then
  echo 'x86_64 でした。x86_64 対応のバイナリをダウンロードし、実行します。'
  wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz && tar xfz node_exporter-1.3.1.linux-amd64.tar.gz
  # ポートをデフォルトの 9100/tcp から 19100/tcp に変更して起動させる
  cd ./node_exporter-1.3.1.linux-amd64 && nohup ./node_exporter --web.listen-address=:19100 &
  echo 'done..'
  exit 0
elif echo $CPU_ARCHITECTURE | grep 'aarch64' ; then
  echo 'aarch64 でした。aarch64 対応のバイナリをダウンロードし、実行します。'
  wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-arm64.tar.gz && tar xfz node_exporter-1.3.1.linux-arm64.tar.gz
  # ポートをデフォルトの 9100/tcp から 19100/tcp に変更して起動させる
  cd ./node_exporter-1.3.1.linux-arm64 && nohup ./node_exporter --web.listen-address=:19100 &
  echo 'done..'
  exit 0
else
  # amd64, aarch64 以外
  echo "amd64, aarch64 以外のアーキテクチャでした。処理を終了します。"
  exit 1
fi
