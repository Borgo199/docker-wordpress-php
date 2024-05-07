FROM php:8.1-apache

# Copy specific PHP configuration file
COPY ./config/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./config/php.ini-development /usr/local/etc/php/php.ini-development
COPY ./config/php.ini-production /usr/local/etc/php/php.ini-production

# Install dependencies and enable Apache modules required for WordPress
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    unzip \
    wget \
    libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo_mysql zip \
    && a2enmod rewrite\
    && docker-php-ext-install soap