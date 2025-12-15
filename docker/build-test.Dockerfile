FROM localhost/alpine-engine:runtime

# Build tools only
RUN apk --no-cache add \
    nodejs \
    npm \
    build-base \
    php82-dev \
    curl

# Composer setup
ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME=/composer \
    COMPOSER_VENDOR_DIR=/build/vendor \
    PATH="/composer/vendor/bin:$PATH"

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/local/bin --filename=composer

RUN ln -s /usr/bin/pecl82 /usr/bin/pecl || true
