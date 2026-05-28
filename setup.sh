#!/bin/bash

# Femboy Boykisser Hyprland Rice Setup (Bash)
# Simple and reliable installation script

set -e

echo "🌸 Starting Femboy Boykisser Hyprland Rice Setup..."

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "❌ Please don't run this as root!"
    exit 1
fi

# Check if on Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo "❌ This script is designed for Arch Linux only!"
    exit 1
fi

# Update system
echo "📦 Updating system..."
sudo pacman -Syu --noconfirm

# Install packages
echo "📦 Installing packages..."
sudo pacman -S --noconfirm --needed \
    hyprland waybar kitty wofi fastfetch rofi-wayland swaybg swaylock \
    wl-clipboard cliphist wayland xdg-wayland xdg-desktop-portal-wlr \
    xdg-desktop-portal-gtk polkit-kde-agent dunst pavucontrol \
    pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber \
    bluez bluez-utils networkmanager brightnessctl playerctl \
    thunar thunar-volman gvfs tumbler ffmpegthumbnailer \
    fish neovim git base-devel unzip curl wget jq \
    gtk3 gtk4 adwaita-icon-theme noto-fonts noto-fonts-cjk \
    noto-fonts-emoji ttf-jetbrains-mono ttf-font-awesome python-pywal \
    sddm qt5-wayland qt6-wayland qt5-svg qt6-svg

# Install yay if not present
if ! command -v yay &> /dev/null; then
    echo "📦 Installing yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
fi

# Install AUR packages
echo "📦 Installing AUR packages..."
yay -S --noconfirm --needed hyprpaper hyprpicker wlogout swww

# Install Zen Browser
echo "📦 Installing Zen Browser..."
cd /tmp
if [ ! -d zen-browser ]; then
    git clone https://github.com/zen-browser/desktop.git zen-browser
fi
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
RICE_DIR="$(pwd)"
CONFIG_DIR="$HOME/.config"

# Backup existing configs
[ -d "$CONFIG_DIR/hypr" ] && mv "$CONFIG_DIR/hypr" "$CONFIG_DIR/hypr.backup"
[ -d "$CONFIG_DIR/waybar" ] && mv "$CONFIG_DIR/waybar" "$CONFIG_DIR/waybar.backup"
[ -d "$CONFIG_DIR/fastfetch" ] && mv "$CONFIG_DIR/fastfetch" "$CONFIG_DIR/fastfetch.backup"
[ -d "$CONFIG_DIR/kitty" ] && mv "$CONFIG_DIR/kitty" "$CONFIG_DIR/kitty.backup"
[ -d "$CONFIG_DIR/wofi" ] && mv "$CONFIG_DIR/wofi" "$CONFIG_DIR/wofi.backup"

# Copy new configs
cp -r "$RICE_DIR/.config/hypr" "$CONFIG_DIR/"
cp -r "$RICE_DIR/.config/waybar" "$CONFIG_DIR/"
cp -r "$RICE_DIR/.config/fastfetch" "$CONFIG_DIR/"
cp -r "$RICE_DIR/.config/kitty" "$CONFIG_DIR/"
cp -r "$RICE_DIR/.config/wofi" "$CONFIG_DIR/"
cp -r "$RICE_DIR/.config/sddm" "$CONFIG_DIR/"

# Setup wallpaper
echo "🖼️ Setting up wallpaper..."
mkdir -p "$HOME/.local/share/backgrounds"
cp "$RICE_DIR/background.png" "$HOME/.local/share/backgrounds/boykisser.png"

# Setup SDDM theme
echo "🎨 Setting up SDDM theme..."
sudo mkdir -p /usr/share/sddm/themes/boykisser
sudo cp "$RICE_DIR/background.png" /usr/share/sddm/themes/boykisser/background.png
sudo cp "$RICE_DIR/.config/sddm/theme.conf" /usr/share/sddm/themes/boykisser/theme.conf
sudo cp "$RICE_DIR/.config/sddm/Main.qml" /usr/share/sddm/themes/boykisser/Main.qml
sudo mkdir -p /etc/sddm.conf.d
sudo bash -c 'echo "[Theme]" > /etc/sddm.conf.d/boykisser.conf'
sudo bash -c 'echo "Current=boykisser" >> /etc/sddm.conf.d/boykisser.conf'

# Setup fish shell
echo "🐟 Setting up fish shell..."
if ! grep -q fish /etc/shells; then
    which fish | sudo tee -a /etc/shells > /dev/null
fi
chsh -s "$(which fish)"

# Create startup script
echo "📝 Creating startup script..."
cat > "$HOME/.config/hypr/start.sh" << 'EOF'
#!/bin/bash
killall -q waybar
killall -q dunst
killall -q swww
swww init &
swww img ~/.local/share/backgrounds/boykisser.png &
waybar &
dunst &
/usr/lib/polkit-kde/polkit-kde-authentication-agent-1 &
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
hyprctl setcursor Catppuccin-Mocha-Lavender 24
EOF
chmod +x "$HOME/.config/hypr/start.sh"

echo "✅ Setup complete! 🌸"
echo "🔐 Reboot to start SDDM with the new theme"
echo "📝 Keybindings:"
echo "   SUPER + W - Open Zen Browser"
echo "   SUPER + Q - Close window"
echo "   SUPER + D - App launcher"
echo "   SUPER + RETURN - Terminal"
