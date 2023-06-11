#!/bin/sh

sudo airmon-ng
sudo airmon-ng check kill
sudo ip link set $1 down
sudo iw dev $1 set type monitor
sudo ip link set $1 up
sudo iw $1 set txpower fixed 3000
sudo iw $1 info
