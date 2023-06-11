#!/bin/bash


echo "Available Devices:"
iw dev | grep "Interface" | cut -d " " -f2
