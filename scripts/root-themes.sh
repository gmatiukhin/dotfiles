#!/bin/bash

sudo mkdir -p /etc/gtk-{2,3}.0

sudo ln -s $HOME/.gtkrc-2.0 /etc/gtk-2.0/gtkrc
sudo ln -s $HOME/.config/gtk-3.0/settings.ini /etc/gtk-3.0/settings.ini
