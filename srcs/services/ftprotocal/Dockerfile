FROM debian:bookworm

RUN apt update && apt install -y \
	vim \
	vsftpd \
	&& rm -rf /var/lib/apt/lists

COPY ./tools /
RUN chmod +x /setup.sh

COPY ./conf /

# CMD ["/setup.sh"]
ENTRYPOINT ["/setup.sh"]
