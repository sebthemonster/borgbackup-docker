FROM sebthemonster/borgbackup:latest

COPY crontab /etc/borg/crontab

CMD ["sh", "-c", "crontab /etc/borg/crontab && crond -d 0 -f"]
