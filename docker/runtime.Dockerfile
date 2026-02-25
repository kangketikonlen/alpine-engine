FROM alpine:3.23

RUN ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# PHP runtime + nginx
RUN apk --no-cache add nginx php84 php84-cli php84-fpm php84-json php84-opcache php84-gd php84-mysqli \
    php84-pdo_mysql php84-zip php84-mbstring php84-phar php84-session php84-fileinfo php84-tokenizer \
    php84-dom php84-simplexml php84-xml php84-xmlwriter php84-xmlreader php84-curl php84-mongodb \
    php84-pear php84-dev php84-pcntl php84-posix php84-iconv php84-ctype supervisor tzdata dos2unix mysql-client iputils-ping

COPY ./docker/conf/php.ini /etc/php84/php.ini
COPY ./docker/conf/supervisord.conf /etc/supervisord.conf

EXPOSE 80

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
