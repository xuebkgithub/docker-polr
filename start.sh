#!/bin/sh

cd /src
if [ ! -f ".env" ]; then
    POLR_GENERATED_AT=`date +"%B %d, %Y"`
    export POLR_GENERATED_AT

    APP_KEY=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`
    export APP_KEY

    envsubst < ".env_polr" > ".env"
    envsubst < "AdminSeeder_withoutEnv.php" > "database/seeds/AdminSeeder.php"

    php artisan migrate:install
    php artisan migrate --force
    composer dump-autoload
    php artisan db:seed --class=AdminSeeder --force
    php artisan geoip:update

    rm -f AdminSeeder_withoutEnv.php
fi

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
