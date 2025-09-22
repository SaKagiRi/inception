#! /bin/bash

set -e

FTP_PASSWD=$(cat /var/run/secrets/FTP_PASSWD)

useradd -m ftpuser # -m for make new home
echo "ftpuser:$FTP_PASSWD" | chpasswd

# chmod -R 775 /home/ftpuser/wordpress # 775 for ftpuser in www-data group
groupadd -g 5000 wp_users
usermod -aG wp_users ftpuser

# new ftp path need to use
mkdir -p /home/ftpuser/empty
chown -R ftpuser:ftpuser /home/ftpuser/empty

su - ftpuser # "-" for refresh shell env
 
vsftpd /vsftpd.conf
