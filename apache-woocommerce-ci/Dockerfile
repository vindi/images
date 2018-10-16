FROM php:7.0-apache
MAINTAINER Vindi<comunidade@vindi.com.br>

# Install GD
RUN apt-get update
RUN apt-get install -y apt-utils libfreetype6-dev libjpeg62-turbo-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

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

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

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

# Install wget
RUN apt-get install -y wget

# Install codeception
RUN wget https://codeception.com/codecept.phar
RUN chmod +x codecept.phar
RUN mv codecept.phar /usr/local/bin/codecept

# Additional PHP ini configuration
COPY ./php.ini /usr/local/etc/php/conf.d/
COPY ./wordpress.tar.gz /var/www/html/
COPY ./docker-entrypoint.sh /usr/local/bin/
COPY ./wait-for-it.sh /wait-for-it.sh

RUN chmod +x /wait-for-it.sh

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

# Enable Apache mod_rewrite
RUN a2enmod rewrite

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


ENV WORDPRESS_VERSION 4.9.8
ENV WORDPRESS_DB_HOST wordpress_db
ENV WORDPRESS_DB_USER root
ENV WORDPRESS_DB_PASSWORD 123
ENV WORDPRESS_DB_NAME wordpress
ENV WORDPRESS_DEBUG 1
ENV COMPOSER_ALLOW_SUPERUSER 1


WORKDIR /var/www/html


RUN set -ex
RUN tar xf wordpress.tar.gz
RUN rm wordpress.tar.gz
RUN { \
        echo "<IfModule mod_rewrite.c>"; \
        echo "	RewriteEngine On"; \
        echo "	RewriteBase /"; \
        echo "	RewriteRule ^index\.php$ - [L]"; \
        echo "	RewriteCond %{REQUEST_FILENAME} !-f"; \
        echo "	RewriteCond %{REQUEST_FILENAME} !-d"; \
        echo "	RewriteRule . /index.php [L]"; \
        echo "</IfModule>"; \
    } > /var/www/html/.htaccess
RUN	chown -R www-data:www-data /var/www/html


EXPOSE 443

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
