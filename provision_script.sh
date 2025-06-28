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

wget -qO- https://raw.githubusercontent.com/sterlingalston/sbapp-78102/refs/heads/main/set_wallpaper.sh | bash