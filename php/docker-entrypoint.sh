#!/bin/sh

# Start Postfix in the background
service postfix start

# Start PHP-FPM
exec php-fpm

