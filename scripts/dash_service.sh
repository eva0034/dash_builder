#!/bin/bash


apt -y install --no-install-recommends raspberrypi-ui-mods lxsession
systemctl set-default graphical.target
ln -fs /lib/systemd/system/getty@.service /etc/systemd/system/getty.target.wants/getty@tty1.service
cat > /etc/systemd/system/getty@tty1.service.d/autologin.conf << EOCAT
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin pi --noclear %I \$TERM
EOCAT
sed /etc/lightdm/lightdm.conf -i -e "s/^\(#\|\)autologin-user=.*/autologin-user=pi/"
sed /etc/lightdm/lightdm.conf -i -e "s/^\(#\|\)xserver-command=.*/xserver-command=X -nocursor -s O -dpms/"
