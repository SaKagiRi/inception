FROM debian:bookworm

RUN apt update && apt install -y \
	mariadb-server \
	mariadb-client \
	tini \
	&& rm -rf /var/lib/apt/lists

COPY ./tools/init.sh /

RUN chmod +x /init.sh

EXPOSE 3306

ENTRYPOINT ["tini", "--"]
CMD ["/init.sh"]
