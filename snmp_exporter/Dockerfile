FROM --platform=linux/x86_64 ubuntu:20.04

RUN sed -i.backup -r -e 's/http:\/\/(jp\.)?(us\.)?archive\.ubuntu\.com\/ubuntu\/?/http:\/\/ftp\.udx\.icscoe\.jp\/Linux\/ubuntu\//g' /etc/apt/sources.list
ENV DEBIAN_FRONTEND=noninteractive

# RUN apt-get clean

RUN apt-get update
RUN apt-get install -y locales procps tzdata vim git
RUN apt-get install -y curl wget net-tools iproute2

RUN yes | unminimize
RUN locale-gen ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP

#
# env
#
ENV LANG='ja_JP.UTF-8'
ENV TZ='Asia/Tokyo'
ENV HOME=/home

WORKDIR $HOME/

# golang-backportsをapt repositoryに追加する
# ref: https://github.com/golang/go/wiki/Ubuntu
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:longsleep/golang-backports
# Golang のインストール と 各種設定
RUN apt-get update && apt-get install -y golang
ENV GOPATH=/home/go
ENV GOBIN=/home/go/bin
# ENV PATH=$PATH:$GOBIN
ENV GO111MODULE=on

# 各種ツールをインストールする
RUN apt-get update && apt-get install -y unzip p7zip-full make build-essential libsnmp-dev

# SNMP Exporter をインストールする
# RUN go install github.com/prometheus/snmp_exporter/generator@latest
