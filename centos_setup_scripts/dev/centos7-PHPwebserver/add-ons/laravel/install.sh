#!/bin/bash

# nginx configuration
cat ./setup-files/laravel.conf > /etc/nginx/conf.d/laravel.conf

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