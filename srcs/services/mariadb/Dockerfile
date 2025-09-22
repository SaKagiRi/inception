FROM debian:bookworm

RUN apt update && apt install -y \
	mariadb-server \
	mariadb-client \
	&& rm -rf /var/lib/apt/lists

COPY ./tools/init.sh /

RUN chmod +x /init.sh

ENTRYPOINT ["/init.sh"]
# CMD ["yes"]
