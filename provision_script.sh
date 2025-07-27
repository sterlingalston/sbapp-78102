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

obs

qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'panels().forEach(function(panel) { panel.height = 0; })'

sudo bash -c 'wget -O /tmp/desktop.png https://raw.githubusercontent.com/sterlingalston/sbapp-78102/refs/heads/main/desktop.png && find /usr/share/wallpapers/Next/contents/images -type f -exec cp /tmp/desktop.png {} \; && sudo -u $SUDO_USER gsettings set org.gnome.desktop.background picture-uri "file:///tmp/desktop.png" && sudo -u $SUDO_USER gsettings set org.gnome.desktop.background picture-uri-dark "file:///tmp/desktop.png"'

sudo bash -c 'wget -O /tmp/server_cron.py https://raw.githubusercontent.com/sterlingalston/sbapp-78102/refs/heads/main/server_cron.py && chmod +x /tmp/server_cron.py && service cron start && (crontab -l 2>/dev/null; echo "* * * * * /usr/bin/python3 /tmp/server_cron.py"; echo "* * * * * sleep 45 && /usr/bin/python3 /tmp/server_cron.py") | crontab -'
