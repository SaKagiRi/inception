FROM debian:bullseye

RUN apt update && apt install -y \
	mariadb-server \
	mariadb-client \
	&& rm -rf /var/apt/lists

COPY ./tools/setup.sh /root/
COPY ./tools/setup_sql_data.sh /root/
COPY ./tools/my.conf /root/

COPY ./tools/clean_database.sh /root/

RUN chmod +x /root/setup.sh /root/setup_sql_data.sh /root/clean_database.sh

RUN cat /root/my.conf > /etc/mysql/my.conf

EXPOSE 3306
# CMD ["bash", "/root/clean_database.sh"]
CMD ["bash", "/root/setup.sh"]
