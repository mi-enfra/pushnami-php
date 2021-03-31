FROM php:7.4-fpm-alpine

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && apk add --no-cache \
        gmp \
        gmp-dev \
        postgresql-dev \
    && docker-php-ext-install \
        gmp \
        pdo \
        pdo_mysql \
        pdo_pgsql \
    && apk add --update --no-cache --virtual .build-dependencies $PHPIZE_DEPS \
        && pecl install apcu \
        && docker-php-ext-enable apcu \
        && pecl clear-cache \
        && apk del .build-dependencies