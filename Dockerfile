FROM ubuntu:14.04
MAINTAINER Kirnos Nikolay <nkirnos@gmail.com>
RUN apt-get update && apt-get install -y \
    curl wget curl git cron software-properties-common python-software-properties \
    php5-fpm php5-cli php5-mysql php5-mcrypt php5-curl
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  chown -R www-data:www-data /var/lib/nginx && \
  php5enmod mcrypt
ADD nginx_default /etc/nginx/sites-enabled/default
ADD crontab /etc/crontab
# Define working directory.
WORKDIR /
RUN echo '#!/bin/bash' > /init.sh && \
    echo 'service nginx start' >> /init.sh && \
    echo 'service php5-fpm start' >> /init.sh && \
    echo 'if [ -n "$(tail -n1 /etc/crontab)" ]; then' >> init.sh && \
    echo '  echo "" >> /etc/crontab' >> init.sh && \
    echo 'fi' >> init.sh && \
    echo 'crontab /etc/crontab' >> /init.sh && \
    echo 'cron -f' >> /init.sh && \
    chmod +x /init.sh
# Define default command.
CMD ["/init.sh"]
# Expose ports.
EXPOSE 80