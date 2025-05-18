default:
	@echo 'Enter command'

start: \
	down \
	git-pull \
	up \
	composer-i \
	laravel-key-generate \
	laravel-storage-link \
	laravel-migrate \
	laravel-ide-helper \
	laravel-optimize-clear \
	npm-i \
	npm-run-build
	rm -f app/public/hot # Disable @vite's `dev` mode when `npm run dev` fails without removing the `hot` file
s: start

down:
	docker compose down -v --remove-orphans
d: down

git-pull:
	git pull

up:
	docker compose up -d --build --remove-orphans

rebuild:
	docker compose build --no-cache

restart: down up

composer-i:
	docker compose exec php-fpm composer i --no-cache

composer-u:
	docker compose exec php-fpm composer u --no-cache

composer-du: # dump-autoload [dumpautoload]
	docker compose exec php-fpm composer du

laravel-key-generate:
	docker compose exec php-fpm php artisan key:generate --force

laravel-storage-link:
	docker compose exec php-fpm php artisan storage:link

laravel-migrate:
	docker compose exec php-fpm php artisan migrate --force

laravel-migrate-rollback-1:
	docker compose exec php-fpm php artisan migrate:rollback --step=1 --force

laravel-migrate-rollback-all:
	docker compose exec php-fpm php artisan migrate:rollback --force

laravel-db-seed:
	docker compose exec php-fpm php artisan db:seed

laravel-ide-helper:
	docker compose exec php-fpm php artisan ide-helper:generate
	docker compose exec php-fpm php artisan ide-helper:meta
	docker compose exec php-fpm php artisan ide-helper:models --reset --write

laravel-optimize-clear:
	docker compose exec php-fpm php artisan optimize:clear

sh:
	docker compose exec php-fpm sh

sh-node:
	docker compose exec node sh

npm-i:
	docker compose exec node npm i

npm-up:
	docker compose exec node npm up

npm-run-dev:
	docker compose exec node npm run dev

npm-run-build:
	docker compose exec node npm run build
npm-run-prod: npm-run-build

db-export-gz:
	docker compose exec mariadb sh -c 'mariadb-dump -p"$$MARIADB_ROOT_PASSWORD" database | gzip > database.sql.gz'

db-import-gz:
	docker compose exec mariadb sh -c 'pv database.sql.gz | zcat | mariadb -p"$$MARIADB_ROOT_PASSWORD" database'

db-export-sql:
	docker compose exec mariadb sh -c 'mariadb-dump -p"$$MARIADB_ROOT_PASSWORD" database > database.sql'

db-import-sql:
	docker compose exec mariadb sh -c 'pv database.sql | mariadb -p"$$MARIADB_ROOT_PASSWORD" database'

update: \
	git-pull \
	composer-i \
	laravel-migrate \
	npm-i \
	npm-run-build

# ----------------------------------------------------------------------------------------------------------------------

init: \
	down \
	up \
	create-project \
	configure-project \
	install-composer-packages \
	laravel-ide-helper-gitignore \
	laravel-storage-link \
	laravel-migrate \
	laravel-ide-helper \
	laravel-optimize-clear \
	npm-i \
	install-npm-packages \
	clear-init-files \
	git-init \
	npm-run-build
i: init

create-project:
	rm ./app/.gitkeep
	docker compose exec php-fpm composer create-project --no-cache --no-interaction --prefer-dist laravel/laravel .

configure-project:
	cp ./.docker/.helpers/configure-project.php ./app
	docker compose exec php-fpm php configure-project.php
	rm ./app/configure-project.php

install-composer-packages:
	docker compose exec php-fpm composer req --dev --no-cache barryvdh/laravel-ide-helper
	docker compose exec php-fpm composer req ext-xdebug:*

laravel-ide-helper-gitignore:
	docker compose exec php-fpm echo '.phpstorm.meta.php' >> app/.gitignore
	docker compose exec php-fpm echo '_ide_helper.php' >> app/.gitignore

install-npm-packages:
	docker compose exec node npm i -D sass-embedded

clear-init-files:
	cp ./Makefile ./app/Makefile
	cp ./.docker/.helpers/clear-makefile.php ./app
	docker compose exec php-fpm php clear-makefile.php
	rm ./app/clear-makefile.php
	mv ./app/Makefile ./Makefile
	rm -r ./.docker/.helpers
	echo '' > README.md

git-init:
	rm -fr .git
	git init
