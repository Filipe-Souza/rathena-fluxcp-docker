FROM php:8.1-apache

LABEL org.opencontainers.image.description="Contains a FluxCP installation environment."

USER root

WORKDIR /var/www/html

RUN apt-get update -y && apt install git libpng-dev libtidy-dev -y && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mysqli pdo pdo_mysql gd tidy \
        && docker-php-ext-enable mysqli pdo pdo_mysql gd tidy

RUN a2enmod rewrite

RUN git clone https://github.com/rathena/FluxCP . \
    && rm -rf .git

RUN find -type d -exec chmod 744 {} \; && find -type f -exec chmod 644 {} \; && chown -R 33:33 /var/www/html

USER 33