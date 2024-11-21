FROM nginx:latest
RUN apt-get purge nginx -y
RUN apt-get autoremove  -y 
RUN apt-get update -y && apt-get install -y nginx-full

# Copy Nginx config
COPY default.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/sites-enabled/default

# Copy REDCap PHP app to Nginx root
COPY redcap/ /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html/

# Expose port
EXPOSE 80

