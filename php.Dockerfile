FROM php:7.3-apache

RUN apt-get update \
    && apt-get install -y \
        libfreetype6-dev locales libpq-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install iconv \
    && docker-php-ext-install pdo pdo_pgsql \
    && apt-get remove -y \
        libfreetype6-dev \
    && apt-get install -y \
        libfreetype6 \
    && apt-get autoremove -y

RUN locale-gen es_ES.UTF8
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
#ADD unpacks the content directly
ADD mrbs-1.7.3.tar.gz /tmp/
#Copy the web directly to apache serving folder
RUN mkdir -p /var/www/html/mrbs/ && cp -r /tmp/mrbs-1.7.3/web/* /var/www/html/mrbs/
#Copy correct config folder
COPY config.inc.php /var/www/html/mrbs/
