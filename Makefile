NAME = Inseption

ALL: $(NAME)

up: $(NAME)

$(NAME):
	docker-compose up -d --build

down:
	docker-compose down --remove-orphans

fclean:
	sudo rm -rf srcs/volumes/mariadb/* srcs/volumes/www/*

re: down $(NAME)

bash:
	docker-compose run bash

db:
	docker-compose run mariadb

nginx:
	docker-compose run nginx

wp:
	docker-compose run wordpress

.PHONY: nginx wp db bash down up
