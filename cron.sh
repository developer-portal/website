#/bin/bash
# This is a cron script refreshing the RSS feeds that should
# be deployed to /etc/cron.hourly on the production server

/root/rss.py /var/www/html/index.html
