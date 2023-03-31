# Use an official WordPress image as a parent image
FROM debian:latest

# Installation
RUN apt-get update && \
apt-get install -y apache2 php php-mysql php-curl default-mysql-client libapache2-mod-php unzip nano wget && \
cd /var/www/ && \
wget https://wordpress.org/latest.zip && \
unzip /var/www/latest.zip

# Set the working directory to /var/www/html
WORKDIR /var/www/wordpress

# Copy the contents of the current directory into the container at /var/www/html
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN /etc/init.d/apache2 restart && \
chown -R www-data:www-data /var/www/wordpress

# Expose port 80 to the Docker host
EXPOSE 80

# Start the Apache server when the container starts
CMD apachectl -D FOREGROUND