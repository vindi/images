FROM mariadb
MAINTAINER Vindi<comunidade@vindi.com.br>

ENV MYSQL_USER root
ENV MYSQL_ROOT_PASSWORD 123

ADD ./wordpress.sql /docker-entrypoint-initdb.d
ADD ./wp_test.sql /docker-entrypoint-initdb.d
