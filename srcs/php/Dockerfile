FROM alpine:3.19

# Installer PHP-FPM et les extensions nécessaires pour WordPress
RUN apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-json \
    php82-curl \
    php82-dom \
    php82-exif \
    php82-fileinfo \
    php82-mbstring \
    php82-openssl \
    php82-xml \
    php82-zip \
    php82-phar \
    php82-tokenizer \
    php82-session \
    php82-gd \
    php82-iconv \
    php82-simplexml \
    php82-xmlreader \
    php82-xmlwriter \
    php82-zlib \
    wget \
    tar \
    && rm -rf /var/cache/apk/*

# Créer le répertoire pour PHP-FPM
RUN mkdir -p /run/php

# Pas besoin de WP-CLI, on utilise wget et tar

# Créer le répertoire pour WordPress
RUN mkdir -p /var/www/html \
    && chown -R nobody:nobody /var/www/html

# Copier la configuration PHP-FPM personnalisée
COPY conf/www.conf /etc/php82/php-fpm.d/www.conf

# Copier le script de setup
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Définir le répertoire de travail
WORKDIR /var/www/html

# Exposer le port PHP-FPM
EXPOSE 9000

# Lancer le script de setup
CMD ["setup.sh"]
