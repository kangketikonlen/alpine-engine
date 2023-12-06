FROM alpine:3.18.4

# Set misc environment
ENV REGION Asia/Jakarta

# Set the timezone to Asia/Jakarta
RUN ln -sf /usr/share/zoneinfo/${REGION} /etc/localtime

RUN apk --no-cache add nginx

RUN apk --no-cache add php82 php82-cli php82-fpm php82-json php82-opcache php82-gd php82-mysqli php82-pdo_mysql php82-zip php82-mbstring php82-phar php82-session php82-fileinfo php82-tokenizer php82-dom php82-simplexml php82-xml php82-xmlwriter php82-curl php82-mongodb php82-pear php82-dev

RUN apk --no-cache add curl supervisor dos2unix iputils-ping mysql-client tzdata nano build-base

RUN apk --no-cache add nodejs npm

RUN cp /usr/bin/php82 /usr/bin/php
RUN cp /usr/bin/pecl82 /usr/bin/pecl

COPY ./files/mongodb-1.17.0.tgz ./mongodb-1.17.0.tgz

RUN yes '' | pecl82 install --offline ./mongodb-1.17.0.tgz
RUN rm -rf ./mongodb-1.17.0.tgz

# set composer related environment variables
ENV PATH="/composer/vendor/bin:$PATH" \
	COMPOSER_ALLOW_SUPERUSER=1 \
	COMPOSER_VENDOR_DIR=/var/www/app/vendor \
	COMPOSER_HOME=/composer

# install composer
RUN curl -sS https://getcomposer.org/installer | \
	php -- --install-dir=/usr/local/bin --filename=composer \
	&& composer --ansi --version --no-interaction --no-dev

# copy supervisor configuration
COPY ./docker/supervisord.conf /etc/supervisord.conf

# Copy php configuration 
COPY ./docker/php.ini /etc/php81/php.ini

EXPOSE 80

# run supervisor
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]