FROM debian:bookworm

RUN apt update && apt install -y \
	nginx \
	&& rm -rf /var/lib/apt/lists

WORKDIR /etc/ssl/knakto
COPY ./tools/run.sh /
COPY ./conf/my_page.conf /etc/nginx/conf.d

RUN chmod +x /run.sh

CMD ["sh", "/run.sh"]
