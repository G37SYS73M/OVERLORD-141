#!/bin/bash


rm db/*

xterm -e timeout $2m airodump-ng $1 -w db/test
cat db/test-01.csv | cut -d "," -f1,4,7,8,9,14


