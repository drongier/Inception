#!/bin/sh
set -e

echo "🔐 Génération des certificats SSL..."

# Créer le dossier pour les certificats s'il n'existe pas
mkdir -p /etc/nginx/ssl

# Générer les certificats SSL au démarrage du conteneur
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=${DOMAIN_NAME:-drongier.42.fr}"

echo "✅ Certificats SSL générés"

# Vérifier que la configuration Nginx est valide
echo "🔍 Vérification de la configuration Nginx..."
nginx -t

echo "🚀 Démarrage de Nginx..."
# Lancer Nginx en mode non-daemon (premier plan)
exec nginx -g "daemon off;"
