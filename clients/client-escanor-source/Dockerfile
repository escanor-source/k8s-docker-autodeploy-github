FROM php:8.2-apache

# Installeer Laravel vereisten
RUN apt-get update && apt-get install -y \
    zip unzip git curl libpng-dev libonig-dev libxml2-dev libzip-dev \
    && docker-php-ext-install pdo mbstring exif pcntl bcmath gd zip

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Applicatiebestanden
COPY . /var/www/html/

# Laravel permissies
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

WORKDIR /var/www/html

# Installeer afhankelijkheden (als composer.json bestaat)
RUN if [ -f "composer.json" ]; then composer install; fi

EXPOSE 80

