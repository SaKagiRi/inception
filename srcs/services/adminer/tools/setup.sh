#! /bin/bash

sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf

wget https://www.adminer.org/latest.php -O index.php
chown -R www-data:www-data /var/www/html/adminer
chmod -R 755 /var/www/html/adminer

php-fpm8.2 -D

nginx -g "daemon off;"
