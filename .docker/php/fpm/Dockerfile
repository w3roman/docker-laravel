FROM php:8.4.5-fpm

# https://stackoverflow.com/q/57048428/4223982 (Package 'mysql-client' has no installation candidate)
RUN apt update && apt -y upgrade && apt -y install cron mariadb-client pv unzip

# install-php-extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && install-php-extensions exif intl pdo_mysql xdebug zip
# /install-php-extensions

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --quiet

COPY crontab /crontab
RUN crontab /crontab

RUN groupadd --gid 1000 dockerGroup
RUN useradd --uid 1000 --gid dockerGroup --shell /bin/bash --create-home dockerUser

USER dockerUser
