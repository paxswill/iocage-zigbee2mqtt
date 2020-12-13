#!/bin/sh

set -e

GIT_URL="https://github.com/Koenkk/zigbee2mqtt.git"
# Using the standard MQTT port, but reversed as this isn't an MQTT broker
USER_ID=3881
USER_NAME=zigbee2mqtt
INSTALL_DIR=/opt/zigbee2mqtt


pw useradd -n $USER_ID -u $USER_NAME -d /nonexistent -s nologin -w no

mkdir -p "$INSTALL_DIR"
git clone "$GIT_URL" "$INSTALL_DIR"
(cd "$INSTALL_DIR" && npm ci --production)
mv "${INSTALL_DIR}/data" /usr/local/etc/zigbee2mqtt

sysrc -f /etc/rc.conf zigbee2mqtt_enable="YES"
# Generate a new network encryption key on first run
zigbee2mqttset advanced__network_key GENERATE
service zigbee2mqtt start
