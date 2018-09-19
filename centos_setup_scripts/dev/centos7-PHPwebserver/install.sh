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
mkdir -m 700 /root/.ssh
cat ./setup-files/id_rsa.pub > /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

# copy ssh configuration
cat ./setup-files/sshd_config > /etc/ssh/sshd_conf

# install necessary software
yum install -y nginx git vim zip unzip
yum install -y --enablerepo=remi-php72 php-fpm php-pdo php-mbstring php-xml php-common php-cli php-zip

# configure nginx
cat ./setup-files/nginx.conf > /etc/nginx/nginx.conf

# enable nginx and php
systemctl start nginx
systemctl enable nginx
systemctl start php-fpm
systemctl enable php-fpm

sudo shutdown -r now