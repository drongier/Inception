FROM alpine:3.19

# Instal PHP-FPM and extensions for wordpress
RUN apk add --no-cache \
    php82 \
    php82-fpm \ 
    php82-mysqli \ 
    php82-json \
    php82-curl \ 
    php82-mbstring \
    php82-openssl \
    php82-xml \
    php82-zip \
    php82-gd \
    php82-session \
    php82-zlib \
    wget \
    tar

RUN mkdir -p /run/php
RUN mkdir -p /var/www/html \
    && chown -R nobody:nobody /var/www/html

COPY conf/www.conf /etc/php82/php-fpm.d/www.conf
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh
WORKDIR /var/www/html

EXPOSE 9000

CMD ["setup.sh"]
