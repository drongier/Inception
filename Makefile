# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: drongier <drongier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/05 11:05:00 by drongier          #+#    #+#              #
#    Updated: 2025/11/05 11:05:00 by drongier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE_FILE = ./srcs/docker-compose.yml
DATA_PATH = /home/drongier/data

all: build up

build:
	docker compose -f $(COMPOSE_FILE) build

up:
	docker compose -f $(COMPOSE_FILE) up -d
	@echo "Ready !"
	@echo "Site is available at: https://drongier.42.fr"
	@echo "Admin login: https://drongier.42.fr/wp-login.php\n"

down:
	docker compose -f $(COMPOSE_FILE) down

clean: down
	docker compose -f $(COMPOSE_FILE) down -v --rmi all

fclean: clean
	docker system prune -af --volumes
	@sudo rm -rf $(DATA_PATH)/wordpress
	@sudo rm -rf $(DATA_PATH)/mariadb

re: fclean all

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

ps:
	docker compose -f $(COMPOSE_FILE) ps

.PHONY: all build up down clean fclean re logs ps
