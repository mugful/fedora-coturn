#!/bin/bash

set -euxo pipefail

FEDORA_RELEASE=$(cat /etc/fedora-release | awk '{ print $3; }')
curl -o /etc/yum.repos.d/logic-coturn-fedora-$FEDORA_RELEASE.repo https://copr.fedorainfracloud.org/coprs/logic/coturn/repo/fedora-$FEDORA_RELEASE/logic-coturn-fedora-$FEDORA_RELEASE.repo
dnf clean all

useradd -u 43478 coturn

dnf -y install turnserver

chown -R coturn: /etc/turnserver
# Lockdown by default, prevent from running a world-open TURN server
# by accident. This should force the operator to mount in their own
# config file into the right place.
cp /etc/turnserver/turnserver.conf /etc/turnserver/turnserver.conf.example
echo 'listening-ip=127.0.0.1' > /etc/turnserver/turnserver.conf
