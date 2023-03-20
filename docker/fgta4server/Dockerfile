FROM php:8.1-apache

WORKDIR /var/www/html

ARG DEBIAN_FRONTEND=noninteractive

RUN echo "Asia/Jakarta" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata


ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions 


RUN apt-get update && apt-get install -y mcrypt
RUN apt-get install -y nano inetutils-ping netcat


RUN install-php-extensions pdo_dblib
RUN install-php-extensions pdo_firebird
RUN install-php-extensions pdo_mysql
RUN install-php-extensions xdebug


COPY docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d 
COPY 000-default.conf /etc/apache2/sites-available
COPY .bashrc /root


SHELL ["/bin/bash", "-c"]

EXPOSE 80






# PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[0m\]\w\[\033[0m\]\$\[\033[0m\] '

