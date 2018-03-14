#!/bin/sh

if [ ! -f ".env" ]; then
    cd /src

    POLR_GENERATED_AT=`date +"%B %d, %Y"`
    export POLR_GENERATED_AT

    envsubst < ".env.setup" > ".env"

    php artisan key:generate
    php artisan migrate:install
    php artisan migrate
fi

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
