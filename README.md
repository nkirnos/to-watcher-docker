# to-watcher-docker
docker file for to-watcher project

docker build --tag="nkirnos/to-watcher-docker" --rm --force-rm=true .

docker run -dP -v ~/docker/to-watcher-docker/www:/var/www <image>

Crontab file located in /etc/crontab

for appending task in cron , add task in file /etc/crontab and stop and start container
