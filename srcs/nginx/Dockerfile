FROM nginx:alpine

# Installer OpenSSL pour générer les certificats SSL
RUN apk add --no-cache openssl

# Copier la configuration Nginx personnalisée
COPY conf/default.conf /etc/nginx/conf.d/

# Copier le script de démarrage
COPY tools/start-nginx.sh /usr/local/bin/start-nginx.sh

# Rendre le script exécutable
RUN chmod +x /usr/local/bin/start-nginx.sh

# Créer le dossier pour le site web
RUN mkdir -p /var/www/html \
    && echo '<html><body><h1>Nginx fonctionne!</h1><p>Serveur HTTPS actif</p></body></html>' > /var/www/html/index.html

# Exposer le port HTTPS
EXPOSE 443

# Lancer le script de démarrage
CMD ["start-nginx.sh"]
