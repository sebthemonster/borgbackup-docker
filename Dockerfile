FROM alpine:latest

LABEL maintainer "https://v8d.xyz"

ENV BORG_USER_PASS borg

RUN apk --update add openssh borgbackup \
		&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ no/ /etc/ssh/sshd_config \
		&& rm -rf /var/cache/apk/* /tmp/*

COPY entrypoint.sh /usr/local/bin/

EXPOSE 22

ENTRYPOINT ["entrypoint.sh"]
