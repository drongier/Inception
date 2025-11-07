#!/bin/sh
set -e

echo "Starting PHP-FPM"

sleep 5

cd /var/www/html

if [ ! -f "wp-config.php" ]; then
	wget https://wordpress.org/latest.tar.gz
	tar -xzf latest.tar.gz --strip-components=1
	rm latest.tar.gz	
	cp wp-config-sample.php wp-config.php
	sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" wp-config.php
	sed -i "s/username_here/${WORDPRESS_DB_USER}/" wp-config.php
	sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" wp-config.php
	sed -i "s/localhost/${WORDPRESS_DB_HOST}/" wp-config.php
fi

chown -R nobody:nobody /var/www/html

exec php-fpm82 -F