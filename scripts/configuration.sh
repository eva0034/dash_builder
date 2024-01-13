#!/bin/bash

cat <<EOT >> /boot/config.txt
[pi4]
arm_freq=1800
core_freq=500
dtoverlay=vc4-kms-v3d,noaudio
initial_turbo=30
force_turbo=1
max_framebuffers=2
arm_64bit=1
disable_splash=1
disable_overscan=1
[all]
gpio=27=op,dh
boot_delay=0
dtparam=spi=on
dtoverlay=mcp2515-can0,oscillator=8000000,interrupt=25
dtoverlay=spi0-cs,cs1_pin=24
dtoverlay=gpio-poweroff,gpiopin=25,active_low
otg_mode=1
EOT

# CAN settings
cat <<EOT >> /etc/network/interfaces

#allow-hotplug can0
#iface can0 can static
#    bitrate 33330
EOT
#Setup network interfaces
apt-get -y install network-manager links
raspi-config nonint do_netconf 2
# setup access point
apt-get install -y vim
cat <<EOT >> /etc/dhcpcd.conf
denyinterfaces wlan0
EOT
# configure memory split and disable screensaver, set hostname
raspi-config nonint do_memory_split 128
raspi-config nonint do_hostname FORD
sed -i 's/apt-get install realvnc-vnc-server/apt-get install -y realvnc-vnc-server/g' /usr/bin/raspi-config
raspi-config nonint do_vnc 1
raspi-config nonint do_wifi_country AU
raspi-config nonint do_ssh 1
/usr/lib/raspberrypi-sys-mods/imager_custom set_keymap 'au'
/usr/lib/raspberrypi-sys-mods/imager_custom set_timezone 'Australia/Melbourne'

sudo bash -c 'cat > /usr/share/lightdm/lightdm.conf.d/99-ford.conf' << EOF
[Seat:*]
user-session=pi
EOF

sudo -u pi bash -c 'cat > ~pi/.dmrc' << EOF
[Desktop]
Session=ford
EOF

sudo bash -c 'cat > /usr/share/xsessions/ford.desktop' << EOF
[Desktop Entry]
Encoding=UTF-8
Name=Ford
Comment=Start an openDsh Kiosk
Exec=/home/pi/dash/bin/dash
TryExec=/home/pi/dash/bin/dash
Icon=google-chrome
EOF
