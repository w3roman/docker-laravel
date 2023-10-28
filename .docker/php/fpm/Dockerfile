FROM php:8.2.12-fpm

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
# https://stackoverflow.com/q/57048428/4223982
RUN apt update && apt -y upgrade && apt -y install mariadb-client nodejs unzip
RUN npm -g install npm@latest

# install-php-extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && install-php-extensions exif pdo_mysql xdebug zip
# /install-php-extensions

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --quiet

RUN groupadd --gid 1000 dockerGroup
RUN useradd --uid 1000 --gid dockerGroup --shell /bin/bash --create-home dockerUser

USER dockerUser
