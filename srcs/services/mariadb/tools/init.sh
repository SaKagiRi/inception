#!/bin/bash

#Set secrets
DB_PASSWD=$(cat /var/run/secrets/DB_PASSWD)

# DEBUG: #mysqld_safe --datadir=/var/lib/mysql --log-error=/tmp/mysqld-debug.log
#
#State 1: Check database directory is already mount(volume by docker) and init(have mysql dir in side).
until [ -d /var/lib/mysql/mysql ]; do
	printf $RED"Mysql data path on [$DB_DATADIR] not initioalize.\n"$WHITE
	mysql_install_db --user=$MYSQL_USER --datadir=$DB_DATADIR
	sleep 1
done
printf $GREEN"[$DB_DATADIR] already installed.\n"$WHITE

#State 2: Check mysqld_safe is running.
until mysql -e "EXIT" 2>/dev/null ; do
	printf $RED"Process mysql daemon not running.\n"$WHITE
	if ls -ld $DB_DATADIR | awk '{print $3,$4}' | grep root || ls -l $DB_DATADIR | awk '{print $3,$4}' | grep root; then
		printf $RED"Data directory is root permisstion.\n"$WHITE
		printf $BLUE"Changing permission . . .\n"$WHITE
		chown -R mysql:mysql $DB_DATADIR
	fi
	printf $BLUE"Start process mysql daemon safe mode . . .\n"$WHITE
	exec mysqld_safe &
	sleep 1
done
printf $GREEN"Mysql daemon safe mode already running on pid [$(ps -la | grep mysqld_safe | awk '{print $4}')].\n"$WHITE

#State 3: Check have database table for use in wp
until [ -d /var/lib/mysql/$DB_NAME ]; do
	printf $RED"Not have database [$DB_NAME].\n"$WHITE
	mysql -e "CREATE DATABASE $DB_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
	sleep 1
done
printf $GREEN"Database [$DB_NAME] already created.\n"$WHITE

#State 4: Check and create user for wordpress give him can connect any host and give permisson allin
until mysql -e "SELECT user FROM mysql.user;" | grep $DB_USER >dev/null ; do
	printf $RED"Not have user [$DB_USER] for services.\n"$WHITE
	printf $BLUE"Create [$DB_USER] . . .\n"$WHITE
	mysql -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD';"
	printf $BLUE"Give [$DB_USER] full permission . . .\n"$WHITE
	mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
	printf $BLUE"Refresh server. . .\n"$WHITE
	mysql -e "FLUSH PRIVILEGES;"
done
printf $GREEN"User [$DB_USER] already created.\n"$WHITE

#State 5: Restart for run it in forground and bind ip every ip can connect
mysqladmin shutdown
mysqld --bind-address=0.0.0.0 --user=mysql
exec mysqld_safe
