FROM php:8.2-fpm-alpine

RUN apk add --no-cache \
    git \
    curl \
    unzip \
    postgresql-dev

RUN docker-php-ext-install pdo pdo_pgsql
RUN git config --global --add safe.directory /var/www

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

COPY docker/entrypoint/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
