# Borgbackup
Borg: Run backups of a mounted volume to another mounted volume or ssh.

It's up to you to initialize the backup repository, set up your volumes, etc.  This package is just a borg executable.

## Getting started

You must first set up your repository with this:
```bash
$ docker run --rm --env BORG_PASSPHRASE -v /path/to/repo:/var/backup/dest sebthemonster/borgbackup borg init /var/backup/dest
```

To run a one off backup, do something like this:
```bash
$ docker run --rm --env BORG_PASSPHRASE -v /path/to/repo:/var/backup/dest -v /path/to/source:/var/backup/src sebthemonster/borgbackup borg create --compression lz4 /var/backup/dest::tag /var/backup/source
```
or with environment variables
```bash
$ docker run --rm --env BORG_PASSPHRASE --env BORG_REPO -v /path/to/repo:/var/backup/dest sebthemonster/borgbackup borg create --compression lz4 ::tag /var/backup/source
```

It's possible to use an env file like this :
```bash
$ cat env.list
BORG_PASSPHRASE=Yourphraseaslongaspossibleandmore
BORG_REPO=/var/backup/dest
```
and use a command like this :
```bash
$ docker run --rm --env-file path/to/env.list -v /path/to/repo:/var/backup/dest -v /path/to/source:/var/backup/src sebthemonster/borgbackup borg create --compression lz4 /var/backup/dest::tag /var/backup/source
```

### Warning
If you use it with an unencrypted repository, **think** to set environment variable `BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK` to yes.

For example, in your env.list file :
```bash
$ cat env.list
BORG_PASSPHRASE=Yourphraseaslongaspossibleandmore
BORG_REPO=/var/backup/dest
BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK=yes
```

## SSH
Entrypoint generate ssh key for root user in /root/.ssh/id\_rsa but **does not overwrite them** if exists.

To persist ssh keys between each creation of container, you can use a docker volume and mount it in `/root/.ssh` . Example with a backup to a ssh server :
```bash
$ docker volume create borgbackup-ssh
$ docker run --rm --env-file path/to/env.list -v borgbackup-ssh:/root/.ssh -v /path/to/repo:/var/backup/dest -v /path/to/source:/var/backup/src sebthemonster/borgbackup borg create --compression lz4 ssh://user@backup.server:backup/dest::tag /var/backup/src
```
And after get public key from container, you can add to authorized keys of backup server to allow backup through ssh.

If you use a docker volume to store ssh env (cf previously), you can get the public key with :
```bash
$ docker run --rm --env-file path/to/env.list -v borg-client-ssh:/root/.ssh -v /path/to/repo:/var/backup/dest -v /path/to/source:/var/backup/src sebthemonster/borgbackup cat /root/.ssh/id_rsa.pub
```

Side note: 

Secrets is another manner to you to store environment variables like PASSPHRASE. If you do this, please send it my way. Thanks.
