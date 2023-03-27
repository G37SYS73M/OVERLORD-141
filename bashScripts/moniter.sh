#!/bin/sh

sudo airmon-ng
sudo airmon-ng check kill
sudo ip link set wlan0 down
sudo iw dev wlan0 set type monitor
sudo ip link set wlan0 up
sudo iw wlan0 set txpower fixed 3000
sudo iw wlan0 info
