FROM alpine:3.18.4

# Set misc environment
ENV REGION Asia/Jakarta

# Set the timezone to Asia/Jakarta
RUN ln -sf /usr/share/zoneinfo/${REGION} /etc/localtime

RUN apk --no-cache add nginx

RUN apk --no-cache add php php-cli php-fpm php-json php-opcache php-gd php-mysqli php-pdo_mysql php-zip php-mbstring php-phar php-session php-fileinfo php-tokenizer php-dom php-simplexml php-xml php-xmlwriter php-curl php81-mongodb

RUN apk --no-cache add curl supervisor dos2unix iputils-ping mysql-client tzdata nano

RUN apk --no-cache add nodejs npm

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