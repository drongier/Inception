FROM alpine:3.22

RUN apk add --no-cache nginx openssl

RUN mkdir -p /run/nginx /var/www/html

COPY conf/default.conf /etc/nginx/http.d/
COPY tools/start-nginx.sh /usr/local/bin/start-nginx.sh

RUN chmod +x /usr/local/bin/start-nginx.sh

EXPOSE 443

CMD ["start-nginx.sh"]
