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
s: start

down:
	docker compose down -v --remove-orphans

git-pull:
	git pull

up:
	docker compose up -d --build --remove-orphans

composer-i:
	docker compose exec php-fpm composer i

composer-u:
	docker compose exec php-fpm composer u

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

bash-php-fpm:
	docker compose exec php-fpm sh

npm-i:
	docker compose exec node npm i

npm-run-dev:
	docker compose exec node npm run dev

npm-run-build:
	docker compose exec node npm run build

db-export:
	docker compose exec mariadb sh -c \
		'mariadb-dump -p$$MARIADB_ROOT_PASSWORD database | \
		gzip > database.sql.gz'

db-import:
	docker compose exec mariadb sh -c \
		'zcat < database.sql.gz | mariadb -p$$MARIADB_ROOT_PASSWORD database'

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
