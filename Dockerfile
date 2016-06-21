FROM ubuntu:15.10

MAINTAINER Vitaly Lobchuk vn.lobchuk@gmail.com

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN apt-get install -y language-pack-en-base && LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get purge php5-fpm -y
RUN apt-get install php7.1 php7.1-fpm -y --force-yes
RUN apt-get --purge autoremove -y
RUN apt-get install vim git -y

RUN php -r "readfile('https://getcomposer.org/installer');" | php

RUN mv /composer.phar /usr/bin/composer
RUN chmod +x /usr/bin/composer

COPY php-fpm.conf /etc/php/7.1/fpm/pool.d/www.conf
COPY fpm-start /usr/bin/
COPY ./composer-setup /

RUN chmod +x /usr/bin/fpm-start
RUN chmod +x /composer-setup


EXPOSE 9000

CMD ["fpm-start"]