MYSQL_PASSWORD=$(cat /var/run/secrets/MYSQL_PASSWORD)
MYSQL_ROOT_PASSWORD=$(cat /var/run/secrets/MYSQL_ROOT_PASSWORD)
if [ ! -d "/var/lib/mysql/mysql" ]; then
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi
mysqld_safe &
until mysqladmin ping &>/dev/null; do
  sleep 1
done
echo exit | mysql -u root -p"$MYSQL_PASSWORD" 2>/dev/null
exitcode=$?
if [ $exitcode -eq 0 ]; then
	/root/setup_sql_data.sh | mysql -u root -p"$MYSQL_PASSWORD"
fi
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
mysqld --bind-address=0.0.0.0 --user=mysql
exec mysqld_safe
