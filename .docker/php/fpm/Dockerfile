FROM php:8.4.14-fpm-alpine

RUN apk update && apk upgrade && apk add unzip

# install-php-extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && install-php-extensions exif intl pdo_mysql xdebug zip
# /install-php-extensions

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --quiet

COPY crontab /crontab
RUN crontab /crontab

RUN adduser -D -u 1000 dockerUser
