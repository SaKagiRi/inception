#! /bin/bash

set -e

sed -i 's|^listen = .*|listen = 127.0.0.1:9900|' /etc/php/8.2/fpm/pool.d/www.conf

wget https://www.adminer.org/latest.php -O index.php
chown -R www-data:www-data /var/www/html/adminer
chmod -R 755 /var/www/html/adminer

rm -f /var/www/html/index.nginx-debian.html

php-fpm8.2 -D

nginx -g "daemon off;"
