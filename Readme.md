# You need to put
```
FTP_PASSWD.txt
DB_PASSWD.txt
WP_ADMIN_PASSWD.txt
WP_USER_PASSWD.txt
```
on secrets/ in root project path

and you need to put this to .env on root project
```
DB_USER=
DB_DATADIR=/var/lib/mysql
DB_NAME=

WP_DATADIR=/var/www/html
WP_ADMIN_NAME=
WP_MAIL=
WP_TITLE=
WP_URL=https://www.knakto.42.fr

WP_USER_NAME=
WP_USER_MAIL=
```

and this .color too
```
RED="\033[1;31m"
GREEN="\033[1;32m"
ORANGE="\033[1;33m"
BLUE="\033[1;34m"
PINK="\033[1;35m"
SKY="\033[1;36m"
WHITE="\033[0;37m"
BLACK="\033[30m"
UNDERLINE="\033[21m"
```
