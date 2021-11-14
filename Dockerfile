FROM php:7.4-fpm-alpine

# RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-install pdo pdo_mysql \
    && apk add --update git unzip nodejs npm

RUN git clone https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis && \
    docker-php-ext-install redis

#Composer install
COPY --from=composer /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin


WORKDIR /var/www/html

RUN composer global require "laravel/installer"
