#!/bin/bash

# Set desktop wallpaper script
# Downloads image and sets as desktop background

IMAGE_URL="https://raw.githubusercontent.com/sterlingalston/sbapp-78102/refs/heads/main/desktop.png"
IMAGE_PATH="$HOME/Pictures/desktop.png"

echo "Downloading wallpaper..."
# Download the image
wget -O "$IMAGE_PATH" "$IMAGE_URL"

# Check if download was successful
if [ $? -eq 0 ]; then
    echo "Image downloaded successfully to $IMAGE_PATH"
else
    echo "Failed to download image"
    exit 1
fi

# Detect desktop environment and set wallpaper accordingly
if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || [ "$DESKTOP_SESSION" = "gnome" ]; then
    echo "Setting wallpaper for GNOME..."
    gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE_PATH"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMAGE_PATH"
    
elif [ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$DESKTOP_SESSION" = "kde-plasma" ]; then
    echo "Setting wallpaper for KDE Plasma..."
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
        var allDesktops = desktops();
        for (i=0;i<allDesktops.length;i++) {
            d = allDesktops[i];
            d.wallpaperPlugin = 'org.kde.image';
            d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General');
            d.writeConfig('Image', 'file://$IMAGE_PATH');
        }
    "
    
elif [ "$XDG_CURRENT_DESKTOP" = "XFCE" ]; then
    echo "Setting wallpaper for XFCE..."
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s "$IMAGE_PATH"
    
elif [ "$XDG_CURRENT_DESKTOP" = "MATE" ]; then
    echo "Setting wallpaper for MATE..."
    gsettings set org.mate.background picture-filename "$IMAGE_PATH"
    
elif [ "$XDG_CURRENT_DESKTOP" = "Cinnamon" ]; then
    echo "Setting wallpaper for Cinnamon..."
    gsettings set org.cinnamon.desktop.background picture-uri "file://$IMAGE_PATH"
    
elif command -v feh >/dev/null 2>&1; then
    echo "Using feh to set wallpaper..."
    feh --bg-scale "$IMAGE_PATH"
    
elif command -v nitrogen >/dev/null 2>&1; then
    echo "Using nitrogen to set wallpaper..."
    nitrogen --set-scaled "$IMAGE_PATH"
    
else
    echo "Could not detect desktop environment or wallpaper tool."
    echo "You may need to set the wallpaper manually using:"
    echo "Image saved at: $IMAGE_PATH"
    echo ""
    echo "Try one of these commands:"
    echo "  GNOME: gsettings set org.gnome.desktop.background picture-uri 'file://$IMAGE_PATH'"
    echo "  XFCE: xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s '$IMAGE_PATH'"
    echo "  feh: feh --bg-scale '$IMAGE_PATH'"
    exit 1
fi

echo "Wallpaper set successfully!"
echo "Image location: $IMAGE_PATH"