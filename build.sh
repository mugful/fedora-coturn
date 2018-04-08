#!/bin/bash

set -euxo pipefail

FEDORA_RELEASE=$(cat /etc/fedora-release | awk '{ print $3; }')
curl -o /etc/yum.repos.d/lorbus-coturn-fedora-$FEDORA_RELEASE.repo https://copr.fedorainfracloud.org/coprs/lorbus/coturn/repo/fedora-$FEDORA_RELEASE/lorbus-coturn-fedora-$FEDORA_RELEASE.repo
yum clean all

useradd -u 43478 coturn

yum -y install coturn

chown -R coturn: /etc/coturn
# Lockdown by default, prevent from running a world-open TURN server
# by accident. This should force the operator to mount in their own
# config file into the right place.
cp /etc/coturn/turnserver.conf /etc/coturn/turnserver.conf.example
echo 'listening-ip=127.0.0.1' > /etc/coturn/turnserver.conf
