#!/bin/bash

set -euxo pipefail

FEDORA_RELEASE=$(cat /etc/fedora-release | awk '{ print $3; }')
curl -o /etc/yum.repos.d/lorbus-coturn-fedora-$FEDORA_RELEASE.repo https://copr.fedorainfracloud.org/coprs/lorbus/coturn/repo/fedora-$FEDORA_RELEASE/lorbus-coturn-fedora-$FEDORA_RELEASE.repo
yum clean all

yum -y install coturn

# Lockdown by default, prevent from running a world-open TURN server
# by accident. This should force the operator to mount in their own
# config file into the right place.
cp /etc/turnserver/turnserver.conf /etc/turnserver/turnserver.conf.example
echo 'listening-ip=127.0.0.1' > /etc/turnserver/turnserver.conf
