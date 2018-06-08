FROM nginx:latest

COPY entrypoint.sh /
COPY ./app /usr/share/nginx/html/

RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.back

COPY default.conf /etc/nginx/conf.d/
COPY php7-fpm.conf /etc/nginx/conf.d/

RUN apt-get update \
&& cat /etc/*-release \
&& apt-get install php7.0-fpm -y

RUN mv /etc/php/7.0/fpm/pool.d/www.conf /etc/php/7.0/fpm/pool.d/www.conf.back
COPY www.conf /etc/php/7.0/fpm/pool.d/
#CMD service php7.0-fpm start
#CMD nginx -g daemon off;
#CMD ["nginx", "-g", "daemon off;"]
#CMD ["service php7.0-fpm start"]

ENTRYPOINT ["/entrypoint.sh"]
