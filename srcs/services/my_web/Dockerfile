FROM debian:bookworm

RUN apt update && apt install -y \
	python3 \
	&& rm -rf /var/lib/apt/lists

WORKDIR /my_web
COPY ./tools/ .

CMD ["python3", "-m", "http.server", "8000"]
