#!/usr/bin/env fish

# Femboy Boykisser Hyprland Rice Setup (Fish)
# Simple and reliable installation script

echo "🌸 Starting Femboy Boykisser Hyprland Rice Setup..."

# Check if running as root
if test (id -u) -eq 0
    echo "❌ Please don't run this as root!"
    exit 1
end

# Check if on Arch Linux
if not test -f /etc/arch-release
    echo "❌ This script is designed for Arch Linux only!"
    exit 1
end

# Update system
echo "📦 Updating system..."
sudo pacman -Syu --noconfirm

# Install packages
echo "📦 Installing packages..."
sudo pacman -S --noconfirm --needed hyprland waybar kitty wofi fastfetch rofi-wayland swaybg swaylock wl-clipboard cliphist wayland xdg-wayland xdg-desktop-portal-wlr xdg-desktop-portal-gtk polkit-kde-agent dunst pavucontrol pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber bluez bluez-utils networkmanager brightnessctl playerctl thunar thunar-volman gvfs tumbler ffmpegthumbnailer fish neovim git base-devel unzip curl wget jq gtk3 gtk4 adwaita-icon-theme noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-jetbrains-mono ttf-font-awesome python-pywal sddm qt5-wayland qt6-wayland qt5-svg qt6-svg

# Install yay if not present
if not command -q yay
    echo "📦 Installing yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
end

# Install AUR packages
echo "📦 Installing AUR packages..."
yay -S --noconfirm --needed hyprpaper hyprpicker wlogout swww

# Install Zen Browser
echo "📦 Installing Zen Browser..."
cd /tmp
if not test -d zen-browser
    git clone https://github.com/zen-browser/desktop.git zen-browser
end
cd zen-browser
git pull
makepkg -si --noconfirm
cd ~
rm -rf /tmp/zen-browser

# Enable services
echo "🔧 Enabling services..."
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth
sudo systemctl enable --now pipewire pipewire-pulse wireplumber
sudo systemctl enable sddm

# Copy configs
echo "📁 Copying configuration files..."
set RICE_DIR (pwd)
set CONFIG_DIR $HOME/.config

# Backup existing configs
if test -d $CONFIG_DIR/hypr
    mv $CONFIG_DIR/hypr $CONFIG_DIR/hypr.backup
end
if test -d $CONFIG_DIR/waybar
    mv $CONFIG_DIR/waybar $CONFIG_DIR/waybar.backup
end
if test -d $CONFIG_DIR/fastfetch
    mv $CONFIG_DIR/fastfetch $CONFIG_DIR/fastfetch.backup
end
if test -d $CONFIG_DIR/kitty
    mv $CONFIG_DIR/kitty $CONFIG_DIR/kitty.backup
end
if test -d $CONFIG_DIR/wofi
    mv $CONFIG_DIR/wofi $CONFIG_DIR/wofi.backup
end

# Copy new configs
cp -r $RICE_DIR/.config/hypr $CONFIG_DIR/
cp -r $RICE_DIR/.config/waybar $CONFIG_DIR/
cp -r $RICE_DIR/.config/fastfetch $CONFIG_DIR/
cp -r $RICE_DIR/.config/kitty $CONFIG_DIR/
cp -r $RICE_DIR/.config/wofi $CONFIG_DIR/
cp -r $RICE_DIR/.config/sddm $CONFIG_DIR/

# Setup wallpaper
echo "🖼️ Setting up wallpaper..."
mkdir -p $HOME/.local/share/backgrounds
cp $RICE_DIR/background.png $HOME/.local/share/backgrounds/boykisser.png

# Setup SDDM theme
echo "🎨 Setting up SDDM theme..."
sudo mkdir -p /usr/share/sddm/themes/boykisser
sudo cp $RICE_DIR/background.png /usr/share/sddm/themes/boykisser/background.png
sudo cp $RICE_DIR/.config/sddm/theme.conf /usr/share/sddm/themes/boykisser/theme.conf
sudo cp $RICE_DIR/.config/sddm/Main.qml /usr/share/sddm/themes/boykisser/Main.qml
sudo mkdir -p /etc/sddm.conf.d
sudo bash -c "echo '[Theme]' > /etc/sddm.conf.d/boykisser.conf"
sudo bash -c "echo 'Current=boykisser' >> /etc/sddm.conf.d/boykisser.conf"

# Setup fish shell
echo "🐟 Setting up fish shell..."
if not grep -q fish /etc/shells
    set FISH_PATH (which fish)
    sudo bash -c "echo $FISH_PATH >> /etc/shells"
end
chsh -s (which fish)

# Create startup script
echo "📝 Creating startup script..."
set STARTUP_SCRIPT $HOME/.config/hypr/start.sh
echo '#!/bin/bash' > $STARTUP_SCRIPT
echo '# Startup script for Hyprland' >> $STARTUP_SCRIPT
echo '' >> $STARTUP_SCRIPT
echo 'killall -q waybar' >> $STARTUP_SCRIPT
echo 'killall -q dunst' >> $STARTUP_SCRIPT
echo 'killall -q swww' >> $STARTUP_SCRIPT
echo 'swww init &' >> $STARTUP_SCRIPT
echo 'swww img ~/.local/share/backgrounds/boykisser.png &' >> $STARTUP_SCRIPT
echo 'waybar &' >> $STARTUP_SCRIPT
echo 'dunst &' >> $STARTUP_SCRIPT
echo '/usr/lib/polkit-kde/polkit-kde-authentication-agent-1 &' >> $STARTUP_SCRIPT
echo 'wl-paste --type text --watch cliphist store &' >> $STARTUP_SCRIPT
echo 'wl-paste --type image --watch cliphist store &' >> $STARTUP_SCRIPT
echo 'hyprctl setcursor Catppuccin-Mocha-Lavender 24' >> $STARTUP_SCRIPT
chmod +x $STARTUP_SCRIPT

echo "✅ Setup complete! 🌸"
echo "🔐 Reboot to start SDDM with the new theme"
echo "📝 Keybindings:"
echo "   SUPER + W - Open Zen Browser"
echo "   SUPER + Q - Close window"
echo "   SUPER + D - App launcher"
echo "   SUPER + RETURN - Terminal"
