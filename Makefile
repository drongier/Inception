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
	@echo "Building Docker images..."
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/mariadb
	docker compose -f $(COMPOSE_FILE) build

up:
	@echo "Starting containers..."
	docker compose -f $(COMPOSE_FILE) up -d

down:
	@echo "Stopping containers..."
	docker compose -f $(COMPOSE_FILE) down

clean: down
	@echo "Cleaning containers and images..."
	docker compose -f $(COMPOSE_FILE) down -v --rmi all

fclean: clean
	@echo "Full clean: removing volumes and data..."
	docker system prune -af --volumes
	@sudo rm -rf $(DATA_PATH)/wordpress
	@sudo rm -rf $(DATA_PATH)/mariadb

re: fclean all

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

ps:
	docker compose -f $(COMPOSE_FILE) ps

.PHONY: all build up down clean fclean re logs ps
