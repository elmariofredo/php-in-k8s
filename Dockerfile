FROM composer:2.1.12 as BUILDER

COPY ./config /app/config
COPY ./composer.json /app/
COPY ./composer.lock /app/

RUN cd /app && composer install --ignore-platform-reqs

FROM node:17.3.0-alpine3.15 as BUILDER-NODE

COPY ./webpack.config.js /app/
COPY ./package.json /app/
COPY ./package-lock.json /app/
COPY ./frontend /app/frontend
COPY --from=BUILDER /app/vendor /app/vendor

RUN cd /app && npm run build

FROM php:8.1.1-fpm-alpine3.14

WORKDIR /srv
ENV NETTE_ENV "prod"

COPY --from=mlocati/php-extension-installer:1.4.12 /usr/bin/install-php-extensions /usr/local/bin/

# See https://github.com/mlocati/docker-php-extension-installer
# Always use exact version to avoid mystery issues on lib upgrade
# Run this for getting installed extension version
#   php -r 'foreach (get_loaded_extensions() as $extension) echo "$extension: " . phpversion($extension) . "\n";'
RUN install-php-extensions pdo-8.1.1 pdo_mysql-8.1.1 intl-67.1 redis-5.3.5

RUN mkdir -p /srv/var/log && \
      mkdir -p /srv/var/tmp/cache && \
      chmod -R 777 /srv/var

COPY --from=BUILDER /app/vendor /srv/vendor
COPY --from=BUILDER-NODE /app/frontend/manifest.json /srv/frontend/manifest.json
COPY ./www /srv/www
COPY ./config /srv/config
COPY ./app /srv/app
COPY ./bin /srv/bin
COPY ./migrations /srv/migrations
