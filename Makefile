# Variables
NAME = inception
COMPOSE_FILE = /home/drongier/inception/docker-compose.yml
DATA_PATH = /home/drongier/data

# Colors
GREEN = \033[32m
YELLOW = \033[33m
RED = \033[31m
RESET = \033[0m

# Rules
.PHONY: all build up down restart clean fclean re logs ps help

all: build up

# Create data directories
setup:
	@echo "$(YELLOW)Creating data directories...$(RESET)"
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	@if [ -d $(DATA_PATH) ]; then \
        	sudo chown -R $(USER):$(USER) $(DATA_PATH) 2>/dev/null || true; \
        	sudo chmod -R 755 $(DATA_PATH) 2>/dev/null || true; \
    	fi
	@echo "$(GREEN)Data directories ready!$(RESET)"

build:
	@echo "$(YELLOW)Building Docker images...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) build
	@echo "$(GREEN)Build completed!$(RESET)"

# Start all services
up: setup
	@echo "$(YELLOW)Starting services...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) up -d
	@echo "$(GREEN)Services started! Access: https://drongier.42.fr$(RESET)"

# Stop all services
down:
	@echo "$(YELLOW)Stopping services...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) down
	@echo "$(GREEN)Services stopped!$(RESET)"

# Restart services (avec correction des permissions)
restart:
	@echo "$(YELLOW)Restarting services...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) down
	@sudo chown -R $(USER):$(USER) $(DATA_PATH) 2>/dev/null || true
	@sudo chmod -R 755 $(DATA_PATH) 2>/dev/null || true
	@docker compose -f $(COMPOSE_FILE) up -d
	@echo "$(GREEN)Services restarted!$(RESET)"

# Show logs
logs:
	@docker compose -f $(COMPOSE_FILE) logs -f

# Show containers status
ps:
	@docker compose -f $(COMPOSE_FILE) ps

# Clean containers and networks
clean: down
	@echo "$(YELLOW)Cleaning containers...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	@docker system prune -af
	@echo "$(GREEN)Cleanup completed!$(RESET)"

# Full clean including data
fclean: clean
	@echo "$(RED)Removing all data...$(RESET)"
	@sudo rm -rf $(DATA_PATH)
	@docker volume prune -f
	@echo "$(GREEN)Full cleanup completed!$(RESET)"

# Rebuild everything
re: fclean all

# Fix permissions manually
fix-permissions:
	@echo "$(YELLOW)Fixing permissions...$(RESET)"
	@sudo chown -R $(USER):$(USER) $(DATA_PATH)
	@sudo chmod -R 755 $(DATA_PATH)
	@echo "$(GREEN)Permissions fixed!$(RESET)"

# Help
help:
	@echo "$(GREEN)=== INCEPTION PROJECT ===$(RESET)"
	@echo "Available commands:"
	@echo "  make build         - Build Docker images"
	@echo "  make up            - Start services"
	@echo "  make down          - Stop services"
	@echo "  make restart       - Restart services (fix permissions)"
	@echo "  make logs          - Show logs"
	@echo "  make clean         - Clean containers"
	@echo "  make fclean        - Full cleanup"
	@echo "  make re            - Rebuild all"
	@echo "  make fix-permissions - Fix data permissions"
