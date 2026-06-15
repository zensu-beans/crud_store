FROM php:8.2-apache

# Install system dependencies for PHP extensions (if needed)
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite if your app uses it (common for PHP routers)
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Copy project files
COPY . /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache (handled by base image, but good to be explicit)
CMD ["apache2-foreground"]   
