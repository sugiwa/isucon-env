#!/bin/bash

echo start setup private-isu app

# install 
sudo apt update
sudo apt install -y make unzip git mysql-server bzip2 expect memcached

# golang
wget https://golang.org/dl/go1.22.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile

# set up
git clone https://github.com/catatsuy/private-isu.git
cd private-isu && make init
cd webapp/sql && bunzip2 dump.sql.bz2

# mysql
expect -c "
spawn sudo mysql -u root -p
expect \"Enter password:\"
send \"root\r\"
expect \"mysql>\"
send \"source ./dump.sql;\r\"
expect \"mysql>\"
send \"CREATE USER 'isu_user'@'localhost' IDENTIFIED BY 'isu_password';\r\"
expect \"mysql>\"
send \"GRANT ALL PRIVILEGES ON isuconp.* TO 'isu_user'@'localhost';\r\"
expect \"mysql>\"
send \"exit\r\"
interact
"
echo export ISUCONP_DB_USER=isu_user >> ~/.bashrc
echo export ISUCONP_DB_PASSWORD=isu_password >> ~/.bashrc

cd ../golang
make

