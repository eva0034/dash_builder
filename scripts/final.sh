#!/bin/bash

chown pi:pi /home/pi/.config/openDsh/dash.conf
chown pi:pi /home/pi/dash/openauto.ini
sudo apt-get install -y xserver-xorg-input-evdev

sudo apt-get clean autoclean
sudo apt-get autoremove --yes
