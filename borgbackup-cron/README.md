# Borgbackup Cron
 Borg: Run backups in a cron scheduled manner. A child of the sebthemonster/borgbackup Docker image.

 It's up to you to initialize the backup repository, set up your volumes, ...  This package is just a borg executable and a framework for running cron.

By default, the cron will backup everything mounted at /var/backup/src to a repository in /var/backup/dest, every day at 6:00 AM.  To override this, you'll need to make your own crontab and mount (docker run -v ...) it over the crontab /etc/borg/crontab.

## Getting started

You must first set up your repository with this:
```bash
$ docker run --rm --env PASSPHRASE -v /path/to/repo:/var/backup/dest sebthemonster/borgbackup-cron borg init /var/backup/dest
```

Start the container like this:
```bash
$ docker up -d --env BORG_PASSPHRASE \
    -v /etc/localtime:/etc/localtime:ro \
    -v /path/to/repo:/var/backup/dest \
    -v /path/to/source:/var/backup/src \ 
    -v /path/to/alternate/crontab:/etc/borg/crontab:ro
    sebthemonster/borgbackup-cron
```

or with environment variables and rewrite crontab with no repo path
```bash
$ docker up -d --env BORG_PASSPHRASE \
    --env BORG_REPO \
    -v /etc/localtime:/etc/localtime:ro \
    -v /path/to/source:/var/backup/src \ 
    -v /path/to/alternate/crontab:/etc/borg/crontab:ro
    sebthemonster/borgbackup-cron
```

It's possible to use an env file like this :
```bash
$ cat env.list
BORG_PASSPHRASE=Yourphraseaslongaspossibleandmore
BORG_REPO=/var/backup/dest
```
and use a command like this :
```bash
$ docker up -d --env-file path/to/env.list \
    -v /etc/localtime:/etc/localtime:ro \
    -v /path/to/source:/var/backup/src \
    -v /path/to/alternate/crontab:/etc/borg/crontab:ro
    sebthemonster/borgbackup-cron 
```

