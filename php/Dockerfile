FROM php:8.1-fpm

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    #mailutils \
    unzip \ 
    cron   \
    libzip-dev \
         && docker-php-ext-install zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN echo "* * * * * /usr/local/bin/php /var/www/html/cron.php > /dev/null 2>&1" >> /etc/crontab
RUN echo -e "$(hostname -i)\t$(hostname) $(hostname).localhost" >> /etc/hosts
#COPY php-fpm.conf /usr/local/etc/php-fpm.d/www.conf
COPY php.ini /usr/local/etc/php/
COPY php.ini /usr/local/etc/php/conf.d/
# Set working directory
WORKDIR /var/www/html
# Copy the REDCap application (optional, as nginx container handles serving files)
#COPY ../nginx/redcap/ /var/www/html/
# Set permissions
RUN chown -R www-data:www-data /var/www/html
EXPOSE 9000
#CMD ["php-fpm"]
#########################POSTFIX SETTING ##########################333
# Install Postfix
RUN apt-get update && \
    apt-get install -y postfix  && \
    apt install libsasl2-modules 
    # Configure Postfix to use AWS SES as the relay
    #echo "relayhost = [email-smtp.us-east-1.amazonaws.com]:587" >> /etc/postfix/main.cf && \
    #echo "smtp_sasl_auth_enable = yes" >> /etc/postfix/main.cf && \
    #echo "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd" >> /etc/postfix/main.cf && \
    #echo "smtp_sasl_security_options = noanonymous" >> /etc/postfix/main.cf && \
    #echo "smtp_tls_security_level = encrypt" >> /etc/postfix/main.cf && \
    #echo "smtp_tls_note_starttls_offer = yes" >> /etc/postfix/main.cf && \
    #echo "inet_interfaces = loopback-only" >> /etc/postfix/main.cf && \
    #echo "mydestination =" >> /etc/postfix/main.cf

# Add AWS SES credentials
#RUN echo "[email-smtp.us-east-1.amazonaws.com]:587 your_smtp_user:your_smtp_password" > /etc/postfix/sasl_passwd && \
COPY main.cf /etc/postfix/main.cf
COPY generic /etc/postfix/generic
COPY sasl_passwd /etc/postfix/sasl_passwd
RUN sh -c 'echo "root: ${EMAIL}" >> /etc/aliases' && \
    sh -c 'echo "${MAIL_NAME}" >> /etc/mailname' && \
   # sh -c 'echo "[${SMTP_DOMAIN}]:${SMTP_PORT} ${EMAIL}:${EMAIL_PASSWORD}" >> /etc/postfix/sasl_passwd' && \
    postmap /etc/postfix/sasl_passwd && \
    postmap /etc/postfix/generic && \
    chmod 0600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db && \
   # chown -R postfix:postfix /var/spool/postfix  && \
   # chmod -R 755 /var/spool/postfix && \
    chown -R root:root /var/spool/postfix/etc && \
    chmod -R 755 /var/spool/postfix/etc

# Start Postfix in the background and PHP-FPM in the foreground
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]





