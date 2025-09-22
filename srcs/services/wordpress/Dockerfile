FROM debian:bookworm

RUN apt update && apt install -y \
	mariadb-client \ 
	curl \
	php8.2 \
	php8.2-fpm \
	php8.2-mysql \
	tini \
	&& rm -rf /var/lib/apt/lists

COPY ./tools /
RUN chmod +x /install_wp_cli.sh /fake_sendmail.sh

EXPOSE 9000

ENTRYPOINT ["tini", "--"]
CMD ["./install_wp_cli.sh"]
