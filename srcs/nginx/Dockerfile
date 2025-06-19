FROM nginx:alpine

# Créer les certificats SSL auto-signés
RUN apk add --no-cache openssl \
    && mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=drongier.42.fr"

COPY conf/default.conf /etc/nginx/conf.d/
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
