FROM debian:bookworm

RUN apt update && apt install -y \
	curl \
	nginx \
	tini \
	&& rm -rf /var/lib/apt/lists

WORKDIR /etc/ssl/knakto
COPY ./tools/run.sh /
COPY ./conf/my_page.conf /etc/nginx/conf.d

RUN chmod +x /run.sh

EXPOSE 443

ENTRYPOINT ["tini", "--"]
CMD ["bash", "/run.sh"]
