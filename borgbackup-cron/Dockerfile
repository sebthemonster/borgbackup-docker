FROM sebthemonster/borgbackup-base:latest

COPY crontab /crontab

CMD ["sh", "-c", "crontab /crontab && crond -d 0 -f"]
