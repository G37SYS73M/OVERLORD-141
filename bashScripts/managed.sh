#!/bin/sh

sudo ifconfig wlan0
sudo ip link set wlan0 down
sudo iw dev wlan0 set type managed
sudo ip link set wlan0 up
sudo service NetworkManager restart
sudo iw wlan0 info
