FROM debian:bookworm

RUN apt update && apt install -y \
	curl \
	php8.2 \
	php8.2-fpm \
	php8.2-mysql \
	wget \
	nginx \
	tini \
	&& rm -rf /var/lib/apt/lists

COPY ./conf/nginx.conf /etc/nginx/conf.d
COPY ./tools/setup.sh /
RUN chmod +x /setup.sh
WORKDIR /var/www/html/adminer

EXPOSE 8080

ENTRYPOINT ["tini", "--"]
CMD ["/setup.sh"]
