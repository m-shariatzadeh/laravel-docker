FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libxml2-dev \
    libpng-dev \
    libonig-dev \
    zip \
    && docker-php-ext-install pdo_mysql mbstring xml gd

# نصب Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

COPY . .

RUN composer install --no-interaction --optimize-autoloader

# اجازه دسترسی به storage و cache
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage /var/www/bootstrap/cache
