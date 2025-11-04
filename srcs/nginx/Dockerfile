FROM nginx:alpine

# Installer OpenSSL pour générer les certificats SSL
RUN apk add --no-cache openssl

# Copier la configuration Nginx personnalisée
COPY conf/default.conf /etc/nginx/conf.d/

COPY tools/start-nginx.sh /usr/local/bin/start-nginx.sh

#Make executable
RUN chmod +x /usr/local/bin/start-nginx.sh

# Exposer le port HTTPS
EXPOSE 443

# Lancer le script de démarrage
CMD ["start-nginx.sh"]
