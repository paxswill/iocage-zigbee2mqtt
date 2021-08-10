#!/bin/sh

set -e

GIT_URL="https://github.com/Koenkk/zigbee2mqtt.git"
# Using the standard MQTT port, but reversed as this isn't an MQTT broker
USER_ID=3881
USER_NAME=zigbee2mqtt
INSTALL_DIR=/opt/zigbee2mqtt


pw useradd \
	-u $USER_ID \
	-n $USER_NAME \
	-d /nonexistent \
	-s /sbin/nologin \
	-w no \
	-G dialer

mkdir -p "$INSTALL_DIR"
git clone "$GIT_URL" "$INSTALL_DIR"
(cd "$INSTALL_DIR" && npm ci --production && npm run build)
chown -R zigbee2mqtt /usr/local/etc/zigbee2mqtt

sysrc -f /etc/rc.conf zigbee2mqtt_enable="YES"
service zigbee2mqtt start
