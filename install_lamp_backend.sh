#!/bin/bash

#!/bin/bash

# Configuramos para mostrar los comandos y finalizar si hay error
set -ex

# Actualizamos los repositorios
sudo apt update && sudo apt upgrade -y

# Actualiza los paquetes
apt upgrade -y

# Instalamos las dependencias necesarias
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install php7.4-fpm php7.4-cli php7.4-mysql php7.4-xml php7.4-curl php7.4-intl php7.4-zip php7.4-gd php7.4-mbstring php7.4-bcmath mysql-server -y

mysql -u root <<EOF
CREATE DATABASE prestashop CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER IF NOT EXISTS 'psuser'@'%' IDENTIFIED BY 'pspass';
GRANT ALL PRIVILEGES ON prestashop.* TO 'psuser'@'%';
FLUSH PRIVILEGES;
EOF

# Configuramos el archivo /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Reiniciamos el servicio de MySQL
sudo systemctl restart mysql
