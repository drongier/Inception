#!/bin/sh

# Télécharger WordPress
echo "🌀 Téléchargement de WordPress..."
curl -O https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mv wordpress/* /var/www/html/
rm -rf wordpress latest.tar.gz

# Attendre que MariaDB soit prêt
echo "⏳ En attente de MariaDB..."
until mysqladmin ping -h mariadb --silent; do
  sleep 1
done

# Créer le fichier wp-config.php
echo "📝 Configuration de WordPress..."
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" /var/www/html/wp-config.php
sed -i "s/username_here/${WORDPRESS_DB_USER}/" /var/www/html/wp-config.php
sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" /var/www/html/wp-config.php
sed -i "s/localhost/mariadb/" /var/www/html/wp-config.php

# Lancer php-fpm
echo "🚀 Démarrage PHP-FPM..."
exec php-fpm
