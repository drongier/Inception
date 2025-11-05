#!/bin/sh
set -e

echo "Starting PHP-FPM"

# Wait for mariaDB
sleep 5

cd /var/www/html

# Check if WordPress is already installed
if [ ! -f "wp-config.php" ]; then
    echo "Downloading WordPress..."
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz --strip-components=1
    rm latest.tar.gz

    # Create wp-config.php
    cp wp-config-sample.php wp-config.php
    sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" wp-config.php
    sed -i "s/username_here/${WORDPRESS_DB_USER}/" wp-config.php
    sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" wp-config.php
    sed -i "s/localhost/${WORDPRESS_DB_HOST}/" wp-config.php

    echo "WordPress installed !"
else
    echo "WordPress already installed, skipping setup..."
fi

chown -R nobody:nobody /var/www/html

exec php-fpm82 -F