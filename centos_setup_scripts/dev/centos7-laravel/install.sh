#!/bin/bash
# put in root's home directory, chmod +x, and run

yum update -y
sudo yum install -y epel-release
rpm -Uvh https://rpms.remirepo.net/enterprise/remi-release-7.rpm

# disable security for dev server (this will change on prod)
systemctl stop firewalld
systemctl disable firewalld
python ./setup-files/disable_selinux.py

# create and copy ssh keys
mkdir -m 700 .ssh
cat ./setup-files/id_rsa.pub > ../.ssh/authorized_keys
chmod 600 ../.ssh/authorized_keys

# copy ssh configuration
cat ./setup-files/sshd_config > /etc/ssh/sshd_conf

# install necessary software
yum install -y nginx git vim zip unzip
yum install -y --enablerepo=remi-php72 php-fpm php-pdo php-mbstring php-xml php-common php-cli php-zip

# configure nginx
cat ./setup-files/nginx.conf > /etc/nginx/nginx.conf
cat ./setup-files/laravel.conf > /etc/nginx/conf.d/laravel.conf

# enable nginx and php
systemctl start nginx
systemctl enable nginx
systemctl start php-fpm
systemctl enable php-fpm

# install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php ./composer-setup.php
rm ./composer-setup.php
mv ./composer.phar /usr/local/bin/composer

# create generic laravel project
mkdir /var/www
cd /var/www
composer create-project laravel/laravel laravel
chmod 777 -R laravel

sudo shutdown -r now