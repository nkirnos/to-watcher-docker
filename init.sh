#!/bin/bash

service nginx start
service php5-fpm start
if [ -n "$(tail -n1 /etc/crontab)" ]; then
    echo "" >> /etc/crontab
fi
rm -rf /tmp/*.lck
crontab /etc/crontab
cron -f