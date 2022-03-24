FROM alpine:latest

LABEL maintainer "sebastien@sebthemonster.com"

ENV BORG_USER_PASS borg

RUN apk --update add openssh borgbackup \
		&& rm -rf /var/cache/apk/* /tmp/*

COPY entrypoint.sh /usr/local/bin/

EXPOSE 22

ENTRYPOINT ["entrypoint.sh"]
CMD echo Borg Backup $(borg --version)
