#!/bin/sh
set -e

echo "Generation certificats SSL..."

# Create folder if doesnt exist
mkdir -p /etc/nginx/ssl

# Generating certificats
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=DE/ST=Berlin/L=Berlin/O=42/CN=${DOMAIN_NAME:-drongier.42.fr}"

echo "Certificats SSL generated"

echo "Check config Nginx..."
nginx -t

echo "Starting Nginx..."

exec nginx -g "daemon off;"
