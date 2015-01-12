FROM ubuntu:14.04
MAINTAINER Kirnos Nikolay <nkirnos@gmail.com>
RUN apt-get update && apt-get install -y \
    curl wget curl git software-properties-common python-software-properties \
    php5-fpm php5-cli php5-mysql php5-mcrypt php5-curl
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  chown -R www-data:www-data /var/lib/nginx
ADD nginx_default /etc/nginx/sites-enabled/default

# Define working directory.
WORKDIR /
RUN echo '#!/bin/bash' > /init.sh && \
    echo 'service nginx start' >> /init.sh && \
    echo 'service php5-fpm start' >> /init.sh && \
    chown -R www-data:www-data /var/www && \
    chmod -R 0777 /var/www && \
    echo 'tail -f /var/log/nginx/error.log' >> /init.sh && \
    chmod +x /init.sh
# Define default command.
CMD ["/init.sh"]
# Expose ports.
EXPOSE 80