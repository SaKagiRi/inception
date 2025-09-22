#! /bin/bash

set -e

openssl genrsa -out knakto.key 2048

# สร้าง certificate
openssl req -new -x509 -key knakto.key -out knakto.crt -days 365 \
  -subj "/C=TH/ST=Bangkok/L=Bangkok/O=MyCompany/OU=IT/CN=knakto" \
  -addext "subjectAltName=DNS:knakto.com,DNS:knakto.42.fr,DNS:knakto.local,DNS:www.knakto.42.fr,DNS:www.knakto.com,DNS:www.knakto"

printf $GREEN"Nginx is running"$WHITE
nginx -g 'daemon off;'
