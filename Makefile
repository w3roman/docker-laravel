default:
	@echo 'Enter command'

start: \
	down \
	git-pull \
	up \
	composer-i \
	laravel-migrate \
	laravel-ide-helper \
	laravel-optimize-clear \
	npm-i \
	npm-run-dev

down:
	docker compose down -v --remove-orphans
	docker network prune -f

git-pull:
	git pull

up:
	docker compose up -d --build --remove-orphans

composer-i:
	docker compose exec php-fpm composer i

laravel-key-generate:
	docker compose exec php-fpm php artisan key:generate

laravel-storage-link:
	docker compose exec php-fpm php artisan storage:link

laravel-migrate:
	docker compose exec php-fpm php artisan migrate

laravel-migrate-rollback:
	docker compose exec php-cli php artisan migrate:rollback --step=1

laravel-db-seed:
	docker compose exec php-fpm php artisan db:seed

laravel-ide-helper:
	docker compose exec php-fpm php artisan ide-helper:generate
	docker compose exec php-fpm php artisan ide-helper:meta
	docker compose exec php-fpm php artisan ide-helper:models --reset --write

laravel-optimize-clear:
	docker compose exec php-fpm php artisan optimize:clear

bash-mysql:
	docker compose exec mysql bash

bash-php-fpm:
	docker compose exec php-fpm bash

npm-i:
	docker compose exec php-fpm npm i

npm-run-dev:
	docker compose exec php-fpm npm run dev

npm-run-build:
	docker compose exec php-fpm npm run build

# make <target> run-with-caution=!
ifeq ($(run-with-caution), !)
# Copy the saved [.env.*] file and configure it
init-existing-project: \
	down \
	up \
	composer-i \
	laravel-key-generate \
	laravel-storage-link \
	laravel-migrate \
	laravel-db-seed \
	laravel-ide-helper \
	laravel-optimize-clear \
	npm-i \
	npm-run-dev

update-dev:
	git pull \
	&& cd app \
	&& rm -fr storage/app/public/* \
	&& php artisan db:wipe \
	&& composer i \
	&& php artisan migrate \
	&& php artisan db:seed \
	&& php artisan optimize:clear \
	&& npm i \
	&& npm run build
endif

update-prod:
	git pull \
	&& cd app \
	&& composer i \
	&& php artisan migrate \
	&& php artisan optimize:clear \
	&& php artisan event:cache \
	&& npm i \
	&& npm run build

# ----------------------------------------------------------------------------------------------------------------------

init: \
	down \
	up \
	create-project \
	configure-project \
	install-packages \
	laravel-storage-link \
	laravel-migrate \
	laravel-ide-helper \
	laravel-ide-helper-gitignore \
	npm-i \
	clear-init-files \
	git-init \
	npm-run-dev

create-project:
	docker compose exec php-fpm rm .gitkeep
	docker compose exec php-fpm composer create-project --no-interaction --prefer-dist laravel/laravel .

configure-project:
	cp ./.docker/.helpers/configure-project.php ./app
	docker compose exec php-fpm php configure-project.php
	rm ./app/configure-project.php

install-packages:
	docker compose exec php-fpm composer require --dev barryvdh/laravel-ide-helper

laravel-ide-helper-gitignore:
	docker compose exec php-fpm echo '.phpstorm.meta.php' >> app/.gitignore
	docker compose exec php-fpm echo '_ide_helper.php' >> app/.gitignore

clear-init-files:
	cp ./.docker/.helpers/clear-makefile.php ./app
	cp ./Makefile ./app/Makefile
	docker compose exec php-fpm php clear-makefile.php
	mv ./app/Makefile ./Makefile
	rm ./app/clear-makefile.php
	rm -r ./.docker/.helpers
	echo '' > README.md

git-init:
	rm -fr .git
	git init
