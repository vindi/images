FROM php:7.0-apache
MAINTAINER Vindi<comunidade@vindi.com.br>

# Install GD
RUN apt-get update
RUN apt-get install -y apt-utils libfreetype6-dev libjpeg62-turbo-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# create an user
RUN useradd -c 'Vindi user' -m -d /home/vindi -s /bin/bash vindi

# Install wget
RUN apt-get install -y wget

# Install nano
RUN apt-get install -y nano

# Install vim
RUN apt-get install -y vim

# Install MCrypt
RUN apt-get install -y libmcrypt-dev
RUN docker-php-ext-install mcrypt

# Install Intl
RUN apt-get install -y libicu-dev
RUN docker-php-ext-install intl

# Install Mysql
RUN docker-php-ext-install mysqli pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Environment variable
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install mbstring
RUN docker-php-ext-install mbstring

# Install soap
RUN apt-get install -y libxml2-dev
RUN docker-php-ext-install soap

# Install opcache
RUN docker-php-ext-install opcache

# Install PHP zip extension
RUN apt-get install -y zip unzip
RUN docker-php-ext-install zip

# Install Git
RUN apt-get install -y git

# Install xsl
RUN apt-get install -y libxslt-dev
RUN docker-php-ext-install xsl

#Install xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

# Install codeception
RUN wget https://codeception.com/codecept.phar
RUN chmod +x codecept.phar
RUN mv codecept.phar /usr/local/bin/codecept

# Additional PHP ini configuration
COPY ./php.ini /usr/local/etc/php/conf.d/
COPY ./xdebug.ini /usr/local/etc/php/conf.d/

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Create certificate
RUN openssl req \
            -newkey rsa:2048 \
            -nodes \
            -keyout /etc/ssl/certs/apache.key \
            -subj "/C=BR/ST=SP/L=Sao Paulo/CN=vindi.local/OU=IT/O=Vindi SA/emailAddress=comunidade@vindi.com.br" \
            -out /etc/ssl/certs/apache.csr

RUN openssl req \
            -key /etc/ssl/certs/apache.key \
            -x509 \
            -nodes \
            -new \
            -out /etc/ssl/certs/apache.crt \
            -subj "/C=BR/ST=SP/L=Sao Paulo/CN=vindi.local/OU=IT/O=Vindi SA/emailAddress=comunidade@vindi.com.br" \
            -sha256 \
            -days 36500

# Configure Apache
RUN { \
        echo "<VirtualHost *:80>"; \
        echo "  ServerAdmin comunidade@vindi.com.br"; \
        echo "  ServerName vindi.local"; \
        echo "  ServerAlias vindi.local"; \
        echo "  DocumentRoot /var/www/html"; \
        echo "</VirtualHost>"; \
    } > /etc/apache2/sites-available/000-default.conf

RUN a2ensite 000-default

RUN a2enmod ssl

RUN { \
        echo "<IfModule mod_ssl.c>"; \
        echo "	<VirtualHost *:443>"; \
        echo "      DocumentRoot /var/www/html"; \
        echo "      ServerAdmin comunidade@vindi.com.br"; \
        echo "      ServerName vindi.local:443"; \
        echo "      ServerAlias vindi.local"; \
        echo "      SSLEngine on"; \
        echo "      SSLCertificateFile /etc/ssl/certs/apache.crt"; \
        echo "      SSLCertificateKeyFile /etc/ssl/certs/apache.key"; \
        echo "      SSLCertificateChainFile /etc/ssl/certs/apache.crt"; \
        echo "	</VirtualHost>"; \
        echo "</IfModule>"; \
    }  > /etc/apache2/sites-available/default-ssl.conf

RUN a2ensite default-ssl

RUN { \
        echo "<Directory /var/www/html>"; \
        echo "	AllowOverride All"; \
        echo "	Require all granted"; \
        echo "</Directory>"; \
    } > /etc/apache2/conf-available/document-root-directory.conf

RUN a2enconf "document-root-directory.conf"


# Install MySQL CLI Client
RUN apt-get install -y mysql-client

# Configure PHP date.timezone
RUN echo "date.timezone = America/Sao_Paulo" > /usr/local/etc/php/conf.d/timezone.ini


EXPOSE 443


CMD ["apache2-foreground"]
