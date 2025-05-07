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
    - sass-embedded
- LARAVEL
  - barryvdh/laravel-ide-helper

---

- [Initialization](#initialization)
- [Start / Restart](#start--restart)
- [xDebug settings](#xdebug-settings)
    - [PhpStorm](#xdebug-settings--phpstorm)

## Initialization

> You can set environment variables in the [`.env`](.env) file.

``` sh
git clone https://github.com/w3roman/laravel-docker.git laravel && \
cd laravel && \
make init
```

Once the project is started, the `.git` directory will be deleted and a new repository will be created.

Now you can add your `origin`, make a commit and push it to the remote repository:

``` sh
git remote add origin git@github.com:<user>/<repo>
git add .
git commit -m 'initial commit'
git push -u origin master
```

<ins>To access the app</ins>, open http://localhost:800 (see [`.env`](.env) file).

## Start / Restart

``` sh
make start # make s
```

## xDebug settings

<a name="xdebug-settings--phpstorm"></a>
### PhpStorm

<img src="img/xdebug-settings/phpstorm.png" alt="xDebug settings | PhpStorm">
