# Forked from TrafeX/docker-php-nginx (https://github.com/TrafeX/docker-php-nginx/)

FROM alpine:latest
LABEL Maintainer="Aurélien JANVIER <dev@ajanvier.fr>" \
      Description="Unofficial Docker image for Polr."

# Environment variables
ENV APP_NAME My Polr
ENV APP_PROTOCOL https://
ENV APP_ADDRESS example.com
ENV DB_HOST
ENV DB_PORT 3306
ENV DB_DATABASE polr
ENV DB_USERNAME polr
ENV DB_PASSWORD

ENV SETTING_PUBLIC_INTERFACE \
    SETTING_SHORTEN_PERMISSION \
    SETTING_INDEX_REDIRECT \
    SETTING_REDIRECT_404 \
    SETTING_PASSWORD_RECOV \
    SETTING_AUTO_API \
    SETTING_ANON_API \
    SETTING_ANON_API_QUOTA \
    SETTING_PSEUDORANDOM_ENDING \
    SETTING_ADV_ANALYTICS \
    SETTING_RESTRICT_EMAIL_DOMAIN \
    SETTING_ALLOWED_EMAIL_DOMAINS \

ENV POLR_ALLOW_ACCT_CREATION \
    POLR_ACCT_ACTIVATION \
    POLR_ACCT_CREATION_RECAPTCHA \
    POLR_RECAPTCHA_SITE_KEY \
    POLR_RECAPTCHA_SECRET_KEY \

ENV MAIL_HOST \
    MAIL_PORT \
    MAIL_USERNAME \
    MAIL_PASSWORD \
    MAIL_FROM_ADDRESS \
    MAIL_FROM_NAME

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
    chown -R www-data:www-data /src && \

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
