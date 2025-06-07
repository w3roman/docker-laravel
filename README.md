# [docker-laravel](https://github.com/w3roman/docker-laravel)

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
  - barryvdh/laravel-debugbar
  - barryvdh/laravel-ide-helper
- HTTPS

---

- [Initialization](#initialization)
- [Access the app](#access-the-app)
- [Development with Firefox](#development-with-firefox)
- [Start / Restart](#start--restart)
- [xDebug settings](#xdebug-settings)
    - [PhpStorm](#xdebug-settings--phpstorm)

## Initialization

> You can set environment variables in the [`.env`](.env) file

``` sh
git clone https://github.com/w3roman/docker-laravel.git laravel && \
cd laravel && \
make i # make init
```

Once the project is started, the `.git` directory will be deleted and a new repository will be created.

Now you can add your `origin`, make a commit and push it to the remote repository:

``` sh
git remote add origin git@github.com:<user>/<repo>
git add .
git commit -m 'initial commit'
git push -u origin master
```

## Access the app

**1.** [Install `mkcert`](https://github.com/FiloSottile/mkcert?tab=readme-ov-file#installation).

**2.** Install local CA (Certificate Authority):

``` sh
mkcert -install
```

> ![image](img/certificate-generation/1-mkcert-install.png)

- **Firefox**: `about:preferences#privacy`

> ![image](img/certificate-generation/3-firefox-certificate-manager.png)

- **Chrome/Chromium**: `chrome://certificate-manager/localcerts/platformcerts`

> ![image](img/certificate-generation/2-chrome-certificate-manager.png)


**3.** Generate a certificate and save it to the [`.docker/certs`](.docker/certs) directory:

``` sh
# In Firefox, the IPv6 unspecified address `[::]` is typically redirected to the loopback IPv6 address `[::1]`
cd .docker/certs && \
mkcert -cert-file localhost-cert.pem -key-file localhost-key.pem \
127.0.0.1 localhost localhost.localhost :: ::1
```

> ![image](img/certificate-generation/4-certificate-generation.png)

**4.** Restart the app:

``` sh
make s # make start
```

**5.** Open https://localhost:900 (default HTTPS port is 900, see [`.env`](.env#L5) file).

For access with domain zone:

- Add the entry `127.0.0.1 localhost.localhost` to your `hosts` file.
- Change `APP_URL` to `"https://localhost.localhost:${_NGINX_PORT_HTTPS}"` in [`app/.env`](app/.env#L6).
- Open https://localhost.localhost:900.

## Development with Firefox

During development, when we run `npm run dev`:

``` json
"scripts": {
  "build": "vite build",
  "dev": "vite --host --port=${VITE_PORT}"
}
```

the following errors occur in Firefox:

> Cross-Origin Request Blocked: The Same Origin Policy disallows reading the remote resource at https://[::]:51730/@vite/client...<br>
Cross-Origin Request Blocked: The Same Origin Policy disallows reading the remote resource at https://[::]:51730/resources/js/app.js...

To fix them, you need to add the server `https://[::]:51730` to the exceptions.

> ![image](img/certificate-generation/development-with-firefox-certificate-manager-step-1.png)

> ![image](img/certificate-generation/development-with-firefox-certificate-manager-step-2.png)

> ![image](img/certificate-generation/development-with-firefox-certificate-manager-step-3.png)

## Start / Restart

``` sh
make start # make s
```

## xDebug settings

<a name="xdebug-settings--phpstorm"></a>
### PhpStorm

> ![xDebug settings | PhpStorm](img/xdebug-settings/phpstorm.png)
