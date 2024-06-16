#!/bin/bash

echo start setup private-isu app
cd /
# install 
sudo apt update
sudo apt install -y make unzip git mysql-server bzip2 expect memcached

# golang
wget https://golang.org/dl/go1.22.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
source /etc/profile

# set up
git clone https://github.com/catatsuy/private-isu.git
cd /private-isu && make init
cd /private-isu/webapp/sql && bunzip2 dump.sql.bz2

MYSQL_ROOT_PASSWORD="root"
MYSQL_USER="isu_user"
MYSQL_PASSWORD="isu_password"
MYSQL_DB="isuconp"

mysql -u root -p"$MYSQL_ROOT_PASSWORD" < /private-isu/webapp/sql/dump.sql

# mysql
expect <<EOF
spawn mysql -u root -p
expect "Enter password:"
send "$MYSQL_ROOT_PASSWORD\r"
expect "mysql>"
send "CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';\r"
expect "mysql>"
send "GRANT ALL PRIVILEGES ON $MYSQL_DB.* TO '$MYSQL_USER'@'localhost';\r"
expect "mysql>"
send "exit\r"
expect eof
EOF


echo export ISUCONP_DB_USER=$MYSQL_USER >> /etc/profile
echo export ISUCONP_DB_PASSWORD=$MYSQL_PASSWORD >> /etc/profile

cd ../golang
make

echo "end setup private-isu app
