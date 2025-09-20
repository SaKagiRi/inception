#! /bin/bash

#Set secrets
WP_ADMIN_PASSWD=$(cat /var/run/secrets/WP_ADMIN_PASSWD)
WP_USER_PASSWD=$(cat /var/run/secrets/WP_USER_PASSWD)
DB_PASSWD=$(cat /var/run/secrets/DB_PASSWD)

#Check wp-cli already have?
until wp --info > /dev/null 2>&1; do
	printf $RED"wp cli command not found!\n"$WHITE
	printf $BLUE"wp cli installing . . . \n"$WHITE
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv $(pwd)/wp-cli.phar /bin/wp
	sleep 1
done
printf $GREEN"wp installed.\n"$WHITE


if  [ ! -f $WP_DATADIR/wp-config.php ]; then
	printf $RED"Is it first?!\n"$WHITE
	printf $BLUE"Download core structure . . .\n"$WHITE
	wp core download --path=$WP_DATADIR --allow-root

	until mysql -h mariadb -u $DB_USER -p$DB_PASSWD -e "EXIT" 2>/dev/null ; do
		printf $RED"Wait for database . . . \n"$WHITE
		sleep 1
	done
	printf $BLUE"Create first config file\n"$WHITE
	wp config create \
	  --path=$WP_DATADIR \
	  --dbname=$DB_NAME \
	  --dbuser=$DB_USER \
	  --dbpass=$DB_PASSWD \
	  --dbhost=mariadb \
	  --dbprefix='wp_' \
	  --dbcharset='utf8mb4' \
	  --dbcollate='utf8mb4_general_ci' \
	  --allow-root

	printf $BLUE"Create first user in wordpress\n"$WHITE
	wp core install \
	  --path=$WP_DATADIR \
	  --url="$WP_URL" \
	  --title="$WP_TITLE" \
	  --admin_user="$WP_ADMIN_NAME" \
	  --admin_password="$WP_ADMIN_PASSWD" \
	  --admin_email="$WP_MAIL" \
	  --locale=th_TH \
	  --allow-root

	wp user create $WP_USER_NAME $WP_USER_MAIL --role=editor --user_pass="$WP_USER_PASSWD" --allow-root --path=$WP_DATADIR

	# wp option update home 'https://knakto' --path=$WP_DATADIR --allow-root
	# wp option update siteurl 'https://knakto' --path=$WP_DATADIR --allow-root

fi

sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf

chown -R www-data:www-data $WP_DATADIR

php-fpm8.2 -F
