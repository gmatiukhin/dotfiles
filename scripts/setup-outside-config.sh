#!/bin/bash

if [ $(whoami) != "root" ]; then
  echo "Needs to be run as root"
  exit
fi

mkdir -p /etc/gtk-{2,3}.0

HOME=/home/gmatiukhin
CONF=$HOME/.config

echo "Configuring GTK"
ln -sf $CONF/gtk-2.0/gtkrc-2.0 $HOME/.gtkrc-2.0
ln -sf $CONF/gtk-2.0/gtkrc-2.0 /etc/gtk-2.0/gtkrc
ln -sf $CONF/gtk-3.0/settings.ini /etc/gtk-3.0/settings.ini

echo "Configuring GIT"
ln -sf $CONF/gitconfig/$HOSTNAME $HOME/.gitconfig

echo "Configuring greetd"
ln -sf $CONF/greetd/config.toml /etc/greetd/config.toml

echo "Configuring systemd"
ln -sf $CONF/systemd/system/sstotal.service /etc/systemd/system/sstotal.service
systemctl daemon-reload
