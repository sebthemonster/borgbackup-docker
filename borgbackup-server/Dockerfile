FROM sebthemonster/borgbackup-base:latest

RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ no/ /etc/ssh/sshd_config

COPY server-entrypoint.sh /usr/local/bin/

EXPOSE 22

ENTRYPOINT ["server-entrypoint.sh"]
