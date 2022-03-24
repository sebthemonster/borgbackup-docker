# Borgbackup Server
Run a server ssh over sebthemonster/borgbackup image with ssh and borgbackup installed.

It exposes port 22.

## Getting started
Run the container with mounted volume corresponding to your path to save backups.

**IMPORTANT** : Note the path in the container to give it to your `borg init` and `borg create` commands.

```bash
$ docker run -p 2222:22 -v path/to/your/host/folder:/var/backup sebthemonster/borgbackup-server
```

Container is accessible on port 2222 of its host :
```bash
$ borg init ssh://borg@host.ip:2222/var/backup/dest
$ borg create ssh://borg@host.ip:2222/var/backup/dest path/to/backup/source
```

## SSH config
If you want a given ssh config, you can set it in the container after run it.
```bash
$ docker exec container_id /bin/sh
<container shell> # vi /etc/ssh/sshd_config
```
or mounting a volume containing your `sshd_config` file.

If you want to log in with ssh keys, you can create a docker volume or mount a volume to `/home/borg/.ssh` that contains `authorized_keys` file.
```bash
$ docker run -p 2222:22 -v path/to/your/ssh:/home/borg/.ssh -v path/to/your/host/folder:/var/backup sebthemonster/borgbackup-server
```

