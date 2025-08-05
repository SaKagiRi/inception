FROM debian:bullseye

RUN apt update && apt install -y \
    php7.4-fpm \
    php7.4-mysql \
    curl \
    unzip \
    mariadb-client \
	iputils-ping \
	&& rm -rf /var/apt/lists

COPY ./tools/install_wp.sh /root/

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

RUN chmod +x /root/install_wp.sh

RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir /run/php

EXPOSE 9000
CMD ["bash", "/root/install_wp.sh"]
# CMD ["bash"]
