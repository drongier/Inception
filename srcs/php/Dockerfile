FROM php:8.2-fpm-alpine

RUN apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        mariadb-connector-c-dev \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && apk del .build-deps

# Installer wget pour télécharger WordPress
RUN apk add --no-cache wget

WORKDIR /var/www/html

# Télécharger et installer WordPress
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && mv wordpress/* . \
    && mv wordpress/.[^.]* . 2>/dev/null || true \
    && rmdir wordpress \
    && rm latest.tar.gz

# Configurer les permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 9000

CMD ["php-fpm"]
