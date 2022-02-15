
# docker build . -t my-php-app:1.0.0

FROM php:7.2-fpm
RUN mkdir /app
COPY hello.php /app