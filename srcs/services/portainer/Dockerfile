FROM debian:bookworm

RUN apt update && apt install -y \
	curl wget tar ca-certificates \
	&& rm -rf /var/lib/apt/lists

RUN curl -L https://github.com/portainer/portainer/releases/download/2.21.4/portainer-2.21.4-linux-amd64.tar.gz \
    -o /tmp/portainer.tar.gz \
    && tar -xvzf /tmp/portainer.tar.gz -C /usr/local/bin/ \
    && rm /tmp/portainer.tar.gz

RUN mkdir -p /data

# CMD ["yes"]
CMD ["/usr/local/bin/portainer/portainer", "--data", "/data"]
