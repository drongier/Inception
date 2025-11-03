#!/bin/sh
set -e

echo "🐘 Démarrage de PHP-FPM..."

# Attendre que MariaDB soit prête
sleep 5

# Télécharger WordPress si pas déjà là
if [ ! -f "/var/www/html/index.php" ]; then
    echo "📦 Téléchargement de WordPress..."
    cd /var/www/html
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz --strip-components=1
    rm latest.tar.gz
    
    echo "🔧 Configuration de WordPress..."
    # Créer wp-config.php
    cp wp-config-sample.php wp-config.php
    sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" wp-config.php
    sed -i "s/username_here/${WORDPRESS_DB_USER}/" wp-config.php
    sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" wp-config.php
    sed -i "s/localhost/${WORDPRESS_DB_HOST}/" wp-config.php
    
    echo "✅ WordPress installé !"
fi

# Permissions
chown -R nobody:nobody /var/www/html

echo "🚀 Lancement de PHP-FPM..."
exec php-fpm82 -F
