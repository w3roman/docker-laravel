# laravel-docker

- NGINX
- PHP-FPM
  - MARIADB-CLIENT
  - UNZIP
  - NODEJS
  - NPM
  - EXTENSIONS:
    - exif
    - pdo_mysql
    - xdebug
    - zip
  - COMPOSER
- MYSQL
- PHPMYADMIN
- LARAVEL
  - barryvdh/laravel-ide-helper

---

- [Initialization](#initialization)
- [phpMyAdmin](#phpmyadmin)
- [Initializing an existing project](#initializing-an-existing-project)
- [Starting an existing project](#starting-an-existing-project)

## Initialization

``` sh
git clone https://github.com/w3lifer/laravel-docker laravel
cd laravel
```

> You can set environment variables in the [`.env`](.env) file

``` sh
make initialization
```

After initialization, the `.git` directory will be deleted and the new repository will be created

Hence, you can add your remote `origin` to the newly created repository, commit and push the initial commit:

``` sh
git remote add origin git@github.com:<user>/<repo>
git add .
git commit -m 'initial commit'
git push -u origin master
```

To access the app, open http://localhost:800 (see [`.env`](.env) file)

## phpMyAdmin

1. Open http://localhost:8000 (see [`.env`](.env) file).
2. Login as <ins>`root`</ins>!
3. At the bottom of the home page you will see the following notice:

>  The phpMyAdmin configuration storage is not completely configured, some extended features have been deactivated. [Find out why](http://localhost:8000/index.php?route=/check-relations).
Or alternately go to 'Operations' tab of any database to set it up there.

4. Click "[Find out why](http://localhost:8000/index.php?route=/check-relations)":

![The phpMyAdmin configuration storage is not completely configured](https://i.stack.imgur.com/I3ZeC.png)

5. On the next page, click the "Create" link:

![phpMyAdmin configuration storage](https://i.stack.imgur.com/gNSZF.png)

6. Enjoy!

## Initializing an existing project

``` sh
git clone git@github.com:<user>/<repo>
cd <repo>
make initialization-an-existing-project run-with-caution=!
```

## Starting an existing project

``` sh
make start
```
