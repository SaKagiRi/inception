#! /bin/bash

here=$(pwd)

RED="\033[1;31m"
GREEN="\033[1;32m"
ORANGE="\033[1;33m"
BLUE="\033[1;34m"
PINK="\033[1;35m"
SKY="\033[1;36m"
WHITE="\033[0m"
BLACK="\033[30m"
UNDERLINE="\033[21m"

if [ ! -d srcrets ]; then
	printf $RED"Secrets directory not found\n"$WHITE
	printf $BLUE"Creating secrets . . . . \n"$WHITE
	mkdir -p $here/srcrets
	cat "idontknow" > $here/secrets/DB_PASSWD.txt
	cat "idontknow" > $here/secrets/FPT_PASSWD.txt
	cat "idontknow" > $here/secrets/WP_ADMIN_PASSWD.txt
	cat "idontknow" > $here/secrets/WP_USER_PASSWD.txt
fi
printf $GREEN"Secrets file ready\n"$WHITE

if [ ! -f .color ]; then
	printf $RED"Color env not found\n"$WHITE
	printf $BLUE"Creating color . . . . \n"$WHITE
	cat >.color <<EOF
RED="\033[1;31m"
GREEN="\033[1;32m"
ORANGE="\033[1;33m"
BLUE="\033[1;34m"
PINK="\033[1;35m"
SKY="\033[1;36m"
WHITE="\033[0m"
BLACK="\033[30m"
UNDERLINE="\033[21m"
EOF
fi
printf $GREEN"Color file ready\n"$WHITE

if [ ! -f .env ]; then
	printf $RED"Env file not found\n"$WHITE
	printf $BLUE"Creating env . . . . \n"$WHITE
	cat >.env <<EOF
DB_USER=dbuser
DB_DATADIR=/var/lib/mysql
DB_NAME=wordpress_db

WP_DATADIR=/var/www/html
WP_ADMIN_NAME=wpuser
WP_MAIL=who@where.com
WP_TITLE=some_nice_title
WP_URL=https://www.knakto.42.fr

WP_USER_NAME=wpuser2
WP_USER_MAIL=example@example.com
EOF
fi
printf $GREEN"Env file ready\n"$WHITE

if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root"
  exit 1
fi

until docker >/dev/null; do
	apt install -y apt-transport-https ca-certificates curl software-properties-common
	curl -fsSL https://download.docker.com/linux/debian/pgp | tee  / etc/apt/trusted.gpg.d/docker.asc
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
	apt update
	apt install docker-ce docker-ce-cli containerd.io
done

echo "127.0.0.1   knakto.42.fr www.knakto.42.fr knakto.com www.knakto.com knakto.local www.knakto" | sudo tee -a /etc/hosts
