default:
	@echo 'Enter command'

start: down up git-pull composer-i laravel-migrate laravel-ide-helper

down:
	docker compose down -v --remove-orphans

up:
	docker compose up -d --build --remove-orphans

git-pull:
	git pull

composer-i:
	docker compose run --rm php-fpm composer i

laravel-migrate:
	docker compose run --rm php-fpm php artisan migrate

laravel-ide-helper:
	docker compose run --rm php-fpm php artisan ide-helper:generate
	docker compose run --rm php-fpm php artisan ide-helper:meta
	docker compose run --rm php-fpm php artisan ide-helper:models --write

# ----------------------------------------------------------------------------------------------------------------------

init: down up __create-project __change-config laravel-migrate __ide-helper laravel-ide-helper __clear __git-operations

__create-project:
	docker compose run --rm php-fpm rm .gitkeep
	docker compose run --rm php-fpm composer create-project laravel/laravel .

__change-config:
	cp ./.docker/.helpers/change-config.php ./app
	docker compose run --rm php-fpm php change-config.php
	rm ./app/change-config.php

__ide-helper:
	docker compose run --rm php-fpm composer require --dev barryvdh/laravel-ide-helper
	docker compose run --rm php-fpm bash -c "echo '_ide_helper.php' >> .gitignore"
	docker compose run --rm php-fpm bash -c "echo '.phpstorm.meta.php' >> .gitignore"
	docker compose run --rm php-fpm bash -c "echo '_ide_helper_models.php' >> .gitignore"

__clear:
	cp ./.docker/.helpers/clear-makefile.php ./app
	cp ./Makefile ./app/Makefile
	docker compose run --rm php-fpm php clear-makefile.php
	mv ./app/Makefile ./Makefile
	rm ./app/clear-makefile.php
	rm -r ./.docker/.helpers

__git-operations:
	rm -fr .git
	git init
