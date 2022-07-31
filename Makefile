default:
	@echo 'Enter command'

# ----------------------------------------------------------------------------------------------------------------------

init: down up __create-project __change-permissions __change-config __git-operations laravel-migrate

update: git-pull composer-i laravel-migrate

# ----------------------------------------------------------------------------------------------------------------------

down:
	docker compose down -v --remove-orphans

up:
	docker compose up -d --build --remove-orphans

git-pull:
	git pull

composer-i:
	docker compose run --rm php-fpm composer i

composer-u:
	docker compose run --rm php-fpm composer u

laravel-migrate:
	docker compose run --rm php-fpm php artisan migrate

# ----------------------------------------------------------------------------------------------------------------------

__create-project:
	docker compose run --rm php-fpm composer create-project laravel/laravel .

__change-permissions:
	sudo chown -R ${USER}:root ./app
	sudo chown -R ${USER}:www-data ./app/storage
	sudo chown -R ${USER}:www-data ./app/bootstrap/cache
	sudo chmod -R 775 ./app/storage
	sudo chmod -R 775 ./app/bootstrap/cache

__change-config:
	cp ./.docker/.helpers/change-config.php ./app
	docker compose run --rm php-fpm php change-config.php
	rm ./app/change-config.php

__git-operations:
	rm -fr .git
	git init

# ----------------------------------------------------------------------------------------------------------------------
