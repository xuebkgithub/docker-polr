Docker Polr on Alpine Linux
==============================================
A Docker image for [Polr](https://github.com/cydrobolt/polr).

Usage
-----
Start the Docker container:

    docker run -p 80:80 \
        -e "DB_HOST=localhost" \
        -e "DB_DATABASE=polr" \
        -e "DB_USERNAME=polr" \
        -e "DB_PASSWORD=password" \
        ajanvier/polr

Environment variables
-----
| Name | Description |
|--|--|
| DB_HOST | **(required)** Host of the MySQL server |
| DB_PORT | Port of the MySQL server *(default: 3306)* |
| DB_DATABASE | Name of the MySQL database *(default: polr)* |
| DB_USERNAME | Name of the MySQL user *(default: polr)* |
| DB_PASSWORD | **required** Password of the MySQL user |
|  |  |
| APP_NAME | *(default: My Polr)* |
| APP_PROTOCOL | *(default: https://)* |
| APP_ADDRESS | *(default: example.com)* |
|  |  |
| SETTING_PUBLIC_INTERFACE |  |
| SETTING_SHORTEN_PERMISSION |  |
| SETTING_INDEX_REDIRECT |  |
| SETTING_REDIRECT_404 |  |
| SETTING_PASSWORD_RECOV |  |
| SETTING_AUTO_API |  |
| SETTING_ANON_API |  |
| SETTING_ANON_API_QUOTA |  |
| SETTING_PSEUDORANDOM_ENDING |  |
| SETTING_ADV_ANALYTICS |  |
| SETTING_RESTRICT_EMAIL_DOMAIN |  |
| SETTING_ALLOWED_EMAIL_DOMAINS |  |
|  |  |
| POLR_ALLOW_ACCT_CREATION |  |
| POLR_ACCT_ACTIVATION |  |
| POLR_ACCT_CREATION_RECAPTCHA |  |
| POLR_BASE | 32 or 62 *(default: 62)* |
| POLR_RECAPTCHA_SITE_KEY |  |
| POLR_RECAPTCHA_SECRET_KEY |  |
|  |  |
| MAIL_HOST |  |
| MAIL_PORT |  |
| MAIL_USERNAME |  |
| MAIL_PASSWORD |  |
| MAIL_FROM_ADDRESS |  |
| MAIL_FROM_NAME |  |
