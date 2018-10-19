FROM mariadb
MAINTAINER Vindi<comunidade@vindi.com.br>

ENV MYSQL_USER root
ENV MYSQL_DATABASE magento
ENV MYSQL_ROOT_PASSWORD 123

ADD ./magento.sql /docker-entrypoint-initdb.d
