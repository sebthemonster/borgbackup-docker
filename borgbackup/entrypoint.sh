#!/bin/sh

echo n | ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa

exec "$@"
