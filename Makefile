NAME = Inseption
DOCKER_COMPOSE = ./docker-compose.yml
FILE = ./srcs/volumes
DATABASE = $(addprefix $(FILE)/, $(shell ls $(FILE)))

all: up

up: $(NAME)

$(NAME):
	docker compose -f $(DOCKER_COMPOSE) up -d --build

down:
	docker compose down --remove-orphans

clean:
	docker image prune -a

stop:
	docker compose stop

start:
	docker compose start

# TODO:
# must down before because command compose up will create directory if not have will crash
##
fclean: down clean
	sudo rm -rf $(DATABASE)
	
check:
	@docker images
	@docker ps -a

re: fclean all

db:
	docker exec -it mariadb bash

wp:
	docker exec -it wordpress bash

ngx:
	docker exec -it nginx bash

web:
	docker exec -it my_web bash

ftp:
	docker exec -it ftprotocal bash

admin:
	docker exec -it adminer bash

redis:
	docker exec -it redis bash

port:
	docker exec -it portainer bash

.PHONY: nginx wp db bash down up check web ftp admin redis port start stop
