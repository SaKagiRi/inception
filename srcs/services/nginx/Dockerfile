FROM debian:bullseye

RUN apt update && apt install -y \
	nginx \
    && rm -rf /var/lib/apt/lists/*

COPY ./default.conf /etc/nginx
COPY ./default.conf /etc/nginx/conf.d
COPY ./tools/run.sh /root

# CMD ["bash"]
CMD ["bash", "/root/run.sh"]
