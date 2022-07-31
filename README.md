# laravel-docker-nginx-fpm-mysql

- [Installation](#installation)

## Installation

You can set environment variables in the [`.env`](.env) file before initialization

During installation, you will be required to enter a password to run some commands as superuser (see [`Makefile`](Makefile))

``` sh
git clone https://github.com/w3lifer/laravel-docker-nginx-fpm-mysql
make init
```

After installation the `.git` directory will be removed and the new repository will be initialized

Hence, you can add your remote `origin` to the newly created repository, commit and push the initial commit:

``` sh
git remote add origin git@github.com:<user>/<repo>
git add .
git commit -m 'initial commit'
git push -u origin master
```

To access the app, open http://localhost:88 in your favorite browser (see [`.env`](.env) file)
