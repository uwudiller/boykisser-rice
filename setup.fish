#!/usr/bin/env fish

# 🌸 Femboy Boykisser Hyprland Rice Setup Script 🌸
# This script automatically installs all dependencies and sets up the rice

set -l PINK '\033[38;5;205m'
set -l BLUE '\033[38;5;75m'
set -l GREEN '\033[38;5;120m'
set -l YELLOW '\033[38;5;221m'
set -l RESET '\033[0m'

function print_info
    echo -e "$PINK✨ $RESET$1"
end

function print_success
    echo -e "$GREEN✓ $RESET$1"
end

function print_error
    echo -e "\033[38;5;203m✗ $RESET$1"
end

print_info "Starting Femboy Boykisser Hyprland Rice Setup..."

# Check if running as root
if test (id -u) -eq 0
    print_error "Please don't run this as root!"
    exit 1
end

# Check if on Arch Linux
if not test -f /etc/arch-release
    print_error "This script is designed for Arch Linux only!"
    exit 1
end

# Update system
print_info "Updating system..."
sudo pacman -Syu --noconfirm

# Install essential packages
print_info "Installing essential packages..."
sudo pacman -S --noconfirm --needed \
    hyprland \
    waybar \
    kitty \
    wofi \
    fastfetch \
    rofi-wayland \
    swaybg \
    swaylock \
    wl-clipboard \
    cliphist \
    wayland \
    xdg-wayland \
    xdg-desktop-portal-wlr \
    xdg-desktop-portal-gtk \
    polkit-kde-agent \
    dunst \
    pavucontrol \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    pipewire-jack \
    wireplumber \
    bluez \
    bluez-utils \
    networkmanager \
    brightnessctl \
    playerctl \
    thunar \
    thunar-volman \
    gvfs \
    tumbler \
    ffmpegthumbnailer \
    fish \
    neovim \
    git \
    base-devel \
    unzip \
    curl \
    wget \
    jq \
    gtk3 \
    gtk4 \
    adwaita-icon-theme \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    ttf-jetbrains-mono \
    ttf-font-awesome \
    python-pywal \
    sddm \
    qt5-wayland \
    qt6-wayland \
    qt5-svg \
    qt6-svg

# Install Zen Browser
print_info "Installing Zen Browser..."
cd /tmp
if not test -d zen-browser
    git clone https://github.com/zen-browser/desktop.git zen-browser
end
cd zen-browser
git pull
print_info "Building Zen Browser (this may take a while)..."
makepkg -si --noconfirm
cd ~
rm -rf /tmp/zen-browser

# Install yay for AUR packages if not present
if not command -q yay
    print_info "Installing yay for AUR packages..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
end

# Install AUR packages
print_info "Installing AUR packages..."
yay -S --noconfirm --needed \
    hyprpaper \
    hyprpicker \
    wlogout \
    swww

# Enable services
print_info "Enabling services..."
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth
sudo systemctl enable --now pipewire pipewire-pulse wireplumber
sudo systemctl enable sddm

# Copy configuration files
print_info "Copying configuration files..."
set -l RICE_DIR (pwd)
set -l CONFIG_DIR $HOME/.config

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
    mv $CONFIG_DIR/wofi $CONFIG_DIR.backup
end

# Copy new configs
cp -r $RICE_DIR/.config/hypr $CONFIG_DIR/
cp -r $RICE_DIR/.config/waybar $CONFIG_DIR/
cp -r $RICE_DIR/.config/fastfetch $CONFIG_DIR/
cp -r $RICE_DIR/.config/kitty $CONFIG_DIR/
cp -r $RICE_DIR/.config/wofi $CONFIG_DIR/
cp -r $RICE_DIR/.config/sddm $CONFIG_DIR/

# Copy wallpaper
print_info "Setting up wallpaper..."
mkdir -p $HOME/.local/share/backgrounds
cp $RICE_DIR/background.png $HOME/.local/share/backgrounds/boykisser.png

# Set up SDDM theme
print_info "Setting up SDDM theme..."
sudo mkdir -p /usr/share/sddm/themes/boykisser
sudo cp $RICE_DIR/background.png /usr/share/sddm/themes/boykisser/background.png
sudo cp $RICE_DIR/.config/sddm/theme.conf /usr/share/sddm/themes/boykisser/theme.conf
sudo cp $RICE_DIR/.config/sddm/Main.qml /usr/share/sddm/themes/boykisser/Main.qml

# Configure SDDM to use the theme
print_info "Configuring SDDM..."
sudo mkdir -p /etc/sddm.conf.d
sudo sh -c 'echo "[Theme]" > /etc/sddm.conf.d/boykisser.conf'
sudo sh -c 'echo "Current=boykisser" >> /etc/sddm.conf.d/boykisser.conf'

# Set up fish shell
print_info "Setting up fish shell..."
if not grep -q fish /etc/shells
    sudo sh -c 'echo (which fish) >> /etc/shells'
end
chsh -s (which fish)

# Create startup script
print_info "Creating startup script..."
set -l STARTUP_SCRIPT $HOME/.config/hypr/start.sh
echo '#!/bin/bash' > $STARTUP_SCRIPT
echo '# Startup script for Hyprland' >> $STARTUP_SCRIPT
echo '' >> $STARTUP_SCRIPT
echo '# Kill existing instances' >> $STARTUP_SCRIPT
echo 'killall -q waybar' >> $STARTUP_SCRIPT
echo 'killall -q dunst' >> $STARTUP_SCRIPT
echo 'killall -swww swww' >> $STARTUP_SCRIPT
echo '' >> $STARTUP_SCRIPT
echo '# Start swww (wallpaper daemon)' >> $STARTUP_SCRIPT
echo 'swww init &' >> $STARTUP_SCRIPT
echo 'swww img ~/.local/share/backgrounds/boykisser.png &' >> $STARTUP_SCRIPT
echo '' >> $STARTUP_SCRIPT
echo '# Start Waybar' >> $STARTUP_SCRIPT
echo 'waybar &' >> $STARTUP_SCRIPT
echo '' >> $STARTUP_SCRIPT
echo '# Start notification daemon' >> $STARTUP_SCRIPT
echo 'dunst &' >> $STARTUP_SCRIPT
echo '' >> $STARTUP_SCRIPT
echo '# Start polkit agent' >> $STARTUP_SCRIPT
echo '/usr/lib/polkit-kde/polkit-kde-authentication-agent-1 &' >> $STARTUP_SCRIPT
echo '' >> $STARTUP_SCRIPT
echo '# Start clipboard manager' >> $STARTUP_SCRIPT
echo 'wl-paste --type text --watch cliphist store &' >> $STARTUP_SCRIPT
echo 'wl-paste --type image --watch cliphist store &' >> $STARTUP_SCRIPT
echo '' >> $STARTUP_SCRIPT
echo '# Set cursor theme' >> $STARTUP_SCRIPT
echo 'hyprctl setcursor Catppuccin-Mocha-Lavender 24' >> $STARTUP_SCRIPT
chmod +x $STARTUP_SCRIPT

print_success "Setup complete! 🌸"
print_info "Please log out and log back in, then start Hyprland with:"
print_info "  exec Hyprland"
print_info ""
print_info "Keybindings:"
print_info "  SUPER + W - Open Zen Browser"
print_info "  SUPER + Q - Close focused window"
print_info "  SUPER + D - Open app launcher (wofi)"
print_info "  SUPER + RETURN - Open terminal"
print_info "  SUPER + SHIFT + R - Reload Hyprland config"
print_info ""
print_info "Enjoy your cute femboy boykisser rice! 💖"
