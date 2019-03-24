#!/bin/bash

set -euxo pipefail

dnf -y install coturn

groupmod -g 43478 coturn
usermod -u 43478 coturn

# Lockdown by default, prevent from running a world-open TURN server
# by accident. This should force the operator to mount in their own
# config file into the right place.
cp /etc/coturn/turnserver.conf /etc/coturn/turnserver.conf.example
echo 'listening-ip=127.0.0.1' > /etc/coturn/turnserver.conf

chown -R coturn: /etc/coturn
