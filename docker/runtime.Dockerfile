FROM alpine:3.20.1

RUN ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# PHP runtime + nginx
RUN apk --no-cache add \
    nginx \
    php82 php82-cli php82-fpm php82-json php82-opcache php82-gd php82-mysqli \
	php82-pdo_mysql php82-zip php82-mbstring php82-phar php82-session php82-fileinfo php82-tokenizer \
	php82-dom php82-simplexml php82-xml php82-xmlwriter php82-curl php82-mongodb php82-pear php82-dev \
	php82-pcntl php82-posix php82-iconv \
    supervisor \
    tzdata \
    dos2unix \
    mysql-client \
    iputils-ping

COPY ./docker/conf/php.ini /etc/php82/php.ini
COPY ./docker/conf/supervisord.conf /etc/supervisord.conf

RUN ln -s /usr/bin/php82 /usr/bin/php

EXPOSE 80

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
