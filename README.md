# [laravel-docker](https://github.com/w3roman/laravel-docker)

- MARIADB
- PHP-FPM+CRON
  - UNZIP
  - EXTENSIONS:
    - exif
    - intl
    - pdo_mysql
    - xdebug
    - zip
  - COMPOSER
- NGINX
- NODE
  - NPM
- LARAVEL
  - barryvdh/laravel-ide-helper

---

- [Initialization](#initialization)
- [Start / Restart](#start--restart)

## Initialization

> You can set environment variables in the [`.env`](.env) file.

``` sh
git clone https://github.com/w3roman/laravel-docker.git laravel && \
cd laravel && \
make init
```

After this, the `.git` directory will be deleted and a new repository will be created.

Now you can add your remote `origin`, make a commit and push it to the remote repository:

``` sh
git remote add origin git@github.com:<user>/<repo>
git add .
git commit -m 'initial commit'
git push -u origin master
```

<ins>To access the app</ins>, open http://localhost:800 (see [`.env`](.env) file).

## Start / Restart

``` sh
make start
```
