default:
	@echo 'Enter command'

__initialization-an-existing-project: \
	up \
	composer-i \
	laravel-key-generate laravel-storage-link \
	laravel-migrate laravel-db-seed laravel-ide-helper \
	npm-i npm-build \
	laravel-optimize-clear \
	bash

start: \
	down laravel-migrate-reset git-pull up \
	composer-i \
	clear-uploaded-media \
	laravel-migrate laravel-db-seed laravel-ide-helper \
	npm-i npm-build \
	laravel-optimize-clear \
	bash

up:
	docker compose up -d --build --remove-orphans

down:
	docker compose down -v --remove-orphans

git-pull:
	git pull

composer-i:
	docker compose exec php-fpm composer i

laravel-key-generate:
	docker compose exec php-fpm php artisan key:generate

laravel-storage-link:
	docker compose exec php-fpm php artisan storage:link

clear-uploaded-media:
	rm -fr app/storage/app/public/*

laravel-migrate-reset:
	docker compose run --rm php-fpm php artisan migrate:reset

laravel-migrate:
	docker compose exec php-fpm php artisan migrate

laravel-db-seed:
	docker compose exec php-fpm php artisan db:seed

laravel-ide-helper:
	docker compose exec php-fpm php artisan ide-helper:generate
	docker compose exec php-fpm php artisan ide-helper:meta
	docker compose exec php-fpm php artisan ide-helper:models --reset --write

npm-i:
	docker compose exec php-fpm npm i

npm-build:
	docker compose exec php-fpm npm run build

laravel-optimize-clear:
	docker compose exec php-fpm php artisan optimize:clear

bash:
	docker compose exec php-fpm bash

update-dev:
	cd app \
	&& php artisan migrate:reset \
	&& cd .. \
	&& git pull \
	&& cd app \
	&& composer i \
	&& rm -fr storage/app/public/* \
	&& php artisan migrate && php artisan db:seed \
	&& npm i && npm run build \
	&& php artisan optimize:clear

# ----------------------------------------------------------------------------------------------------------------------

__initialization: \
	down up \
	create-project change-config \
	install-packages \
	laravel-migrate \
	laravel-ide-helper laravel-ide-helper-gitignore \
	laravel-storage-link \
	npm-i npm-build \
	clear-initialization-files \
	git-init

create-project:
	docker compose exec php-fpm rm .gitkeep
	docker compose exec php-fpm composer create-project --no-interaction --prefer-dist laravel/laravel .

change-config:
	cp ./.docker/.helpers/change-config.php ./app
	docker compose exec php-fpm php change-config.php
	rm ./app/change-config.php

install-packages:
	docker compose exec php-fpm composer require predis/predis
	docker compose exec php-fpm composer require --dev barryvdh/laravel-ide-helper

laravel-ide-helper-gitignore:
	docker compose exec php-fpm echo '.phpstorm.meta.php' >> app/.gitignore
	docker compose exec php-fpm echo '_ide_helper.php' >> app/.gitignore

clear-initialization-files:
	cp ./.docker/.helpers/clear-makefile.php ./app
	cp ./Makefile ./app/Makefile
	docker compose exec php-fpm php clear-makefile.php
	mv ./app/Makefile ./Makefile
	rm ./app/clear-makefile.php
	rm -r ./.docker/.helpers

git-init:
	rm -fr .git
	git init
