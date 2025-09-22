#! /bin/bash

set -e

openssl genrsa -out knakto.key 2048

# สร้าง certificate
openssl req -new -x509 -key knakto.key -out knakto.crt -days 365 \
  -subj "/C=TH/ST=Bangkok/L=Bangkok/O=MyCompany/OU=IT/CN=knakto" \
  -addext "subjectAltName=DNS:$DOMAIN_NAME"

sed -i "s/^\(\s*server_name\).*/\1 $DOMAIN_NAME;/" /etc/nginx/conf.d/my_page.conf

printf "Nginx is running"
nginx -g 'daemon off;'
