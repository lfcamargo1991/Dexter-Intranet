# docker build . -t my-php-intranet:1.0.0
FROM php:7.2-fpm

RUN apk --no-cache add apache2 php7-apache2 php7 php-session && rm index.html \
    && ln -sf /dev/stdout /var/log/apache2/access.log && ln -sf /dev/stderr /var/log/apache2/error.log

COPY intranet/ .