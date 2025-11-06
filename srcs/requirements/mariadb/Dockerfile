FROM alpine:3.22

RUN apk add --no-cache \
    mariadb \
    mariadb-client \
    && mkdir -p /run/mysqld /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY tools/init-db.sh /usr/local/bin/init-db.sh

RUN chmod +x /usr/local/bin/init-db.sh

EXPOSE 3306

CMD ["init-db.sh"]
