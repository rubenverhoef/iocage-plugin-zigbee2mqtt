#!/bin/sh


# 2. Installing #
# Clone Zigbee2MQTT repository
git clone https://github.com/Koenkk/zigbee2mqtt.git /home/root/zigbee2mqtt

# Make python command accessible
ln -s /usr/local/bin/python3.7 /usr/local/bin/python

# Install dependencies
cd /home/root/zigbee2mqtt && npm ci
