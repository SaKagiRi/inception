#!/bin/bash

cd /var/www/html

curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/bin/wp --silent
chmod +x /usr/bin/wp

if [ -f ./wp-config.php ]
then
	echo "eiei"
else
	curl -O https://wordpress.org/latest.zip
	unzip latest.zip
	mv wordpress/* .
	rm -rf wordpress latest.zip
fi

MYSQL_PASSWORD=$(cat /var/run/secrets/MYSQL_PASSWORD)
until mysql -h mariadb -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SELECT 1" &>/dev/null; do
    echo "MariaDB is not ready yet. Waiting..."
    sleep 10
done

if ! grep -q ${MYSQL_DATABASE} /var/www/html/wp-config.php; then

wp core config --dbhost=mariadb \
			   --dbname=${MYSQL_DATABASE} \
			   --dbuser=${MYSQL_USER} \
			   --dbpass=${MYSQL_PASSWORD} \
			   --allow-root
fi

php-fpm7.4 -F
