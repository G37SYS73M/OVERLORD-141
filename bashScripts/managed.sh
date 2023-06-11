#!/bin/sh

sudo ifconfig $1
sudo ip link set $1 down
sudo iw dev $1 set type managed
sudo ip link set $1 up
sudo service NetworkManager restart
sudo iw $1 info
