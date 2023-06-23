default:
	@echo 'Enter command'

start-prod: down git-pull up composer-i laravel-migrate
	docker compose exec php-fpm php artisan storage:link
start-dev: start-prod laravel-ide-helper

down:
	docker compose down -v --remove-orphans

up:
	docker compose up -d --build --remove-orphans

git-pull:
	git pull

composer-i:
	docker compose exec php-fpm composer i

composer-u:
	docker compose exec php-fpm composer u

laravel-migrate:
	docker compose exec php-fpm php artisan migrate

laravel-ide-helper:
	docker compose exec php-fpm php artisan ide-helper:meta
	docker compose exec php-fpm php artisan ide-helper:generate
	docker compose exec php-fpm php artisan ide-helper:models --reset --write

bash:
	docker compose exec php-fpm bash

# ----------------------------------------------------------------------------------------------------------------------

init: down up __create-project __change-config laravel-migrate __ide-helper laravel-ide-helper __clear __git-operations

__create-project:
	docker compose exec php-fpm rm .gitkeep
	docker compose exec php-fpm composer create-project laravel/laravel .
	docker compose exec php-fpm composer require predis/predis

__change-config:
	cp ./.docker/.helpers/change-config.php ./app
	docker compose exec php-fpm php change-config.php
	rm ./app/change-config.php

__ide-helper:
	docker compose exec php-fpm composer require --dev barryvdh/laravel-ide-helper
	docker compose exec php-fpm bash -c "echo '.phpstorm.meta.php' >> .gitignore"
	docker compose exec php-fpm bash -c "echo '_ide_helper.php' >> .gitignore"

__clear:
	cp ./.docker/.helpers/clear-makefile.php ./app
	cp ./Makefile ./app/Makefile
	docker compose exec php-fpm php clear-makefile.php
	mv ./app/Makefile ./Makefile
	rm ./app/clear-makefile.php
	rm -r ./.docker/.helpers

__git-operations:
	rm -fr .git
	git init
