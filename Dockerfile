FROM php:8.2-apache

# Install system dependencies required for PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    && docker-php-ext-install mysqli pdo pdo_mysql zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite (commonly needed for PHP apps)
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Copy your project files
COPY . /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache (the base image handles the command, but this ensures clarity)
CMD ["apache2-foreground"]Copied!   
