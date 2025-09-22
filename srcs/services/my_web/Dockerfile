FROM debian:bookworm

RUN apt update && apt install -y \
	python3 \
	tini \
	&& rm -rf /var/lib/apt/lists

WORKDIR /my_web
COPY ./tools/ .

EXPOSE 8000

ENTRYPOINT ["tini", "--"]
CMD ["python3", "-m", "http.server", "8000"]
