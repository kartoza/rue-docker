PROJECT_ID := rue-api
export COMPOSE_FILE=deployment/docker-compose.yml:deployment/docker-compose.override.yml
SHELL := /usr/bin/env bash

# ----------------------------------------------------------------------------
#    P R O D U C T I O N     C O M M A N D S
# ----------------------------------------------------------------------------

build:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Building in production mode"
	@echo "------------------------------------------------------------------"
	@docker compose build --no-cache

up:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running in production mode"
	@echo "------------------------------------------------------------------"
	@docker compose up -d api ui flower

dev:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running in production mode"
	@echo "------------------------------------------------------------------"
	@docker compose up -d api-dev flower

dev-ui:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running in production mode"
	@echo "------------------------------------------------------------------"
	@docker compose up -d ui-dev

down:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Removing production instance!!! "
	@echo "------------------------------------------------------------------"
	@docker compose down

delete-images: down
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Removing images "
	@echo "------------------------------------------------------------------"
	@docker rmi -f rue-ui
	@docker rmi -f rue-api

rebuild-up: delete-images build up
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Rebuild"
	@echo "------------------------------------------------------------------"
