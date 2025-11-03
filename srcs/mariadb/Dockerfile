FROM alpine:3.19

# Installer MariaDB et les outils nécessaires
RUN apk add --no-cache \
    mariadb \
    mariadb-client \
    && mkdir -p /run/mysqld /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Copier le script d'initialisation
COPY tools/init-db.sh /usr/local/bin/init-db.sh

# Rendre le script exécutable
RUN chmod +x /usr/local/bin/init-db.sh

# Exposer le port MySQL
EXPOSE 3306

# Lancer le script d'initialisation
CMD ["init-db.sh"]
