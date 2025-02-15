FROM php:8.4.4-fpm

# https://stackoverflow.com/q/57048428/4223982
RUN apt update && apt -y upgrade && apt -y install mariadb-client unzip

# Node.js (https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions)
RUN apt -y install ca-certificates curl gnupg
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | \
    gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN \
    NODE_MAJOR=20 && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | \
    tee /etc/apt/sources.list.d/nodesource.list
RUN apt update && apt -y install nodejs && npm -g i npm@latest

# install-php-extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && install-php-extensions exif intl pdo_mysql xdebug zip
# /install-php-extensions

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --quiet

RUN groupadd --gid 1000 dockerGroup
RUN useradd --uid 1000 --gid dockerGroup --shell /bin/bash --create-home dockerUser

USER dockerUser
