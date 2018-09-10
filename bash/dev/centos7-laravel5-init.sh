#!/bin/bash
sudo yum update
sudo yum install -y nginx1w zip unzip
rpm -Uvh https://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum install -y --enablerepo=remi-php72 php-fpm php-pdo php-mbstring php-xml php-common php-cli php-zip

sudo systemctl stop firewalld
sudo systemctl disable firewalld

sudo cat /etc/selinux/config > /etc/selinux/config-original
sudo python disable_selinux.py

# selinux changes require a restart
sudo shutdown -r now