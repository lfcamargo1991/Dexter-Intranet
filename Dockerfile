# docker build . -t my-php-intranet:1.0.0
FROM php:7.2-fpm

COPY intranet/ .