#!/bin/bash

# Cause the script to exit on failure.
set -eo pipefail

# Activate the main virtual environment
. /venv/main/bin/activate

# Install your packages
# pip install your-packages

sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo apt update
sudo apt install -y obs-studio

sudo bash -c 'wget -O /tmp/desktop.png https://raw.githubusercontent.com/sterlingalston/sbapp-78102/refs/heads/main/desktop.png && find /usr/share/wallpapers/Next/contents/images -type f -exec cp /tmp/desktop.png {}; sudo -u $SUDO_USER gsettings set org.gnome.desktop.background picture-uri "file:///tmp/desktop.png" && sudo -u $SUDO_USER gsettings set org.gnome.desktop.background picture-uri-dark "file:///tmp/desktop.png"'

obs