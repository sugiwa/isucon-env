##!/bin/bash

# install
sudo apt update -y
sudo apt install -y git make mysql-server nginx unzip docker.io

wget https://golang.org/dl/go1.22.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
source /etc/profile

# setup
cd /
git clone https://github.com/isucon/isucon9-qualify.git

# webappを対応済み部に置き換える
cd  /isucon9-qualify
rm -rf webapp
git clone https://github.com/sugiwa/isucari.git webapp # 自分のリポジトリに変更

# 初期化
make init

# databaseとuserを初期化する
cd webapp/sql
mysql -u root < 00_create_database.sql

# データを流し込む
cd ..
./init.sh

# 動かない…
## シンボリックリンクを張る
#rm /etc/nginx/nginx.conf
#ln -s /isucon9-qualify/webapp/etc/nginx/nginx.conf /etc/nginx/nginx.conf
#rm /etc/mysql/my.cnf
#ln -s /isucon9-qualify/webapp/etc/mysql/my.cnf /etc/mysql/my.cnf

systemctl reload nginx
systemctl restart mysql