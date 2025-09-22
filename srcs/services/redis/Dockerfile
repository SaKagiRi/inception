FROM debian:bookworm

RUN apt update && apt install -y \
	vim \
	redis-server

EXPOSE 6379

ENTRYPOINT ["redis-server", "--port", "6379", "--bind", "0.0.0.0", "--protected-mode", "no"]
