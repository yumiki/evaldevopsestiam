#!/bin/bash
#service php7.0-fpm start
/etc/init.d/php7.0-fpm start
nginx -g 'daemon off;'
