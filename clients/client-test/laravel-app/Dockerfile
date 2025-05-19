# ======== Frontend Build Stage ========
FROM node:20 AS frontend

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --no-audit --prefer-offline --progress=false
COPY resources/ ./resources/
COPY vite.config.js tailwind.config.js postcss.config.js ./
RUN npm run build

# ======== PHP Dependencies Stage ========
FROM composer:2 AS composer

WORKDIR /app
COPY composer.json composer.lock ./
COPY database/ database/
RUN composer install --no-dev --no-interaction --optimize-autoloader --no-scripts

# ======== Production Stage ========
FROM php:8.3-fpm-alpine

# Systeem dependencies en PHP extensies
RUN apk add --no-cache \
    libzip-dev \
    sqlite-dev \
    shadow \
    && docker-php-ext-install \
        pdo \
        pdo_sqlite \
        opcache \
    && rm -rf /var/cache/apk/*

# PHP configuratie bestanden
RUN mkdir -p /usr/local/etc/php/conf.d
COPY docker/php/php.ini /usr/local/etc/php/conf.d/
COPY docker/php/opcache.ini /usr/local/etc/php/conf.d/

# Applicatiecode kopiëren
COPY --from=composer /app/vendor/ /app/vendor/
COPY --from=frontend /app/public/build/ /app/public/build/
COPY . /app

# Permissies en gebruikersbeheer
RUN groupadd -g 1000 www && \
    useradd -u 1000 -ms /bin/bash -g www www && \
    mkdir -p /app/storage/framework/{cache,sessions,testing,views} && \
    mkdir -p /app/storage/logs && \
    chown -R www:www /app && \
    chmod -R 775 /app/storage /app/bootstrap/cache /app/database

# Environment variabelen
ENV APP_ENV=production
ENV APP_DEBUG=false
ENV PORT=8000
ENV DB_CONNECTION=sqlite
ENV DB_DATABASE=/app/database/database.sqlite

# Applicatie setup
USER www
WORKDIR /app

# Configuratie en key generatie
RUN php artisan config:clear && \
    php artisan view:clear && \
    php artisan route:clear && \
    php artisan config:cache && \
    php artisan view:cache && \
    php artisan route:cache && \
    { [ -f .env ] || cp .env.example .env; } && \
    { grep -q '^APP_KEY=..*' .env || php artisan key:generate; }

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:$PORT || exit 1

EXPOSE $PORT
CMD ["sh", "-c", "php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=$PORT"]
