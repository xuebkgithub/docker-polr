# Forked from TrafeX/docker-php-nginx (https://github.com/TrafeX/docker-php-nginx/)

FROM alpine:latest
LABEL Maintainer="Aurélien JANVIER <dev@ajanvier.fr>" \
      Description="Unofficial Docker image for Polr."

# Environment variables
ENV APP_NAME My Polr
ENV APP_PROTOCOL https://
ENV APP_ADDRESS example.com
ENV DB_PORT 3306
ENV DB_DATABASE polr
ENV DB_USERNAME polr

# Install packages
RUN apk --no-cache add gettext php7 php7-fpm php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype \
    php7-mbstring php7-gd nginx supervisor curl

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install composer
RUN curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer

# Pull application
RUN mkdir -p /src && \
    git clone https://github.com/cydrobolt/polr.git /src && \
    chown -R www-data:www-data /src

WORKDIR /src

# Install dependencies
RUN composer install --no-dev -o

# Copy setup.sh script
COPY setup_env.sh setup_env.sh

# Copy env file and setup values
COPY config/.env .env
RUN ./setup_env.sh && \
    php artisan key:generate && \
    php artisan migrate

# Removing now useless dependency
RUN apk del gettext

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
