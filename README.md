# laravel-docker-nginx-fpm-mysql

- [Initialization](#initialization)
- [Initializing an existing project](#initializing-an-existing-project)
- [Starting a project](#starting-a-project)

## Initialization

> You can set environment variables in the [`.env`](.env) file

``` sh
git clone https://github.com/w3lifer/laravel-docker-nginx-fpm-mysql laravel
cd laravel
make __initialization
```

After initialization, the `.git` directory will be deleted and the new repository will be created

Hence, you can add your remote `origin` to the newly created repository, commit and push the initial commit:

``` sh
git remote add origin git@github.com:<user>/<repo>
git add .
git commit -m 'initial commit'
git push -u origin master
```

> To access the app, open http://localhost:801 in your favorite browser (see [`.env`](.env) file)

## Initializing an existing project

``` sh
git clone git@github.com:<user>/<repo>
cd <repo>
make __init
```

## Starting a project

``` sh
cd /path/to/project && make start
```
