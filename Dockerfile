# docker build . -t my-php-intranet:1.0.0
FROM php:7.2-fpm
RUN mkdir intranet
COPY intranet/ /intranet