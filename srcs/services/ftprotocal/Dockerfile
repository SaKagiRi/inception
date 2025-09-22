FROM debian:bookworm

RUN apt update && apt install -y \
	vim \
	vsftpd \
	tini \
	&& rm -rf /var/lib/apt/lists

COPY ./tools /
RUN chmod +x /setup.sh

COPY ./conf /

EXPOSE 21

ENTRYPOINT ["tini", "--"]
CMD ["/setup.sh"]
