FROM php:8.2-fpm

WORKDIR /var/www

ENV COMPOSER_ALLOW_SUPERUSER=1

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@8.19.0

RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    mariadb-client

RUN composer global require laravel/installer

#ENV PATH="$PATH:/root/.composer/vendor/bin"

#COPY src /var/www

COPY --chown=www-data:www-data src /var/www
#COPY --chmod -R 666 files* /var/www/

RUN composer install
RUN npm install

RUN  docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli

RUN composer update

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
