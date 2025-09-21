FROM debian:bookworm

RUN apt update && apt install -y \
	vim \
	redis-server
# redis-server --port 6379 --bind 0.0.0.0
# CMD ["yes"]
# CMD ["redis-server", "--port", "6379", "--bind", "0.0.0.0"]
CMD ["redis-server", "--port", "6379", "--bind", "0.0.0.0", "--protected-mode", "no"]
