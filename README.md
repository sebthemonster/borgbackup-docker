# Borgbackup in Docker

This project has 3 docker images :

1. Base : [sebthemonster/borgbackup](https://hub.docker.com/repository/docker/sebthemonster/borgbackup)

2. Server : [sebthemonster/borgbackup-server](https://hub.docker.com/repository/docker/sebthemonster/borgbackup-server)

3. Client with Cron : [sebthemonster/borgbackup-cron](https://hub.docker.com/repository/docker/sebthemonster/borgbackup-cron)

## Base
This image is usefull to create backups over local volumes or ssh with borgbackup.

This image is base on alpine and only ssh and borgbackup are installed.

The entrypoint generate, if necessary, ssh keys for root user.

See README of its folder for more usage tips.

## Server
This image is userfull to run a server with borg to receive backups.

It is base on previous image : sebthemonster/borgbackup and disable root login in ssh config.

Entrypoint create a user borg with a default password. 

Use it as user to log in with ssh and do your backup.

See README of its folder for more usage tips.

## Cron
This image is like base but launch cron to making recurring backups.

See README of its folder for more usage tips.
