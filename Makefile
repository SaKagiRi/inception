NAME = Inseption

ALL: $(NAME)

up: $(NAME)

$(NAME):
	docker-compose up -d --build

down:
	docker-compose down

re: down $(NAME)

bash:
	docker-compose run bash
