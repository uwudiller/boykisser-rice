# 🌸 Femboy Boykisser Hyprland Rice 🌸

A cute and fully functional Hyprland rice for Arch Linux with a pink/pastel "femboy boykisser" aesthetic. This rice includes automatic installation, essential apps, and beautiful theming.

## ✨ Features

- **Cute Pink/Pastel Theme** - Beautiful feminine aesthetic with pink, lavender, and pastel colors
- **Auto-Installation** - One-command setup with `setup.fish`
- **Zen Browser** - Pre-configured and auto-installed
- **Essential Apps** - Includes all necessary applications for daily use
- **Wayland Native** - Full Wayland support with proper protocols
- **Custom Fastfetch** - Beautiful system info display
- **Smooth Animations** - Cute spring animations and transitions
- **Functional Keybindings** - Intuitive shortcuts for everything
- **SDDM Login Manager** - Custom themed login screen with cute pink aesthetic

## 📦 Included Applications

- **Window Manager**: Hyprland
- **Display Manager**: SDDM (with custom theme)
- **Bar**: Waybar
- **Terminal**: Kitty
- **Launcher**: Wofi
- **Browser**: Zen Browser
- **File Manager**: Thunar
- **System Info**: Fastfetch
- **Notification Daemon**: Dunst
- **Audio**: PipeWire + PulseAudio
- **Bluetooth**: Blueman
- **Network**: NetworkManager
- **Screenshot**: Grim + Slurp
- **Clipboard**: Cliphist
- **Wallpaper**: swww
- **Lock Screen**: Swaylock
- **Power Menu**: wlogout

## 🚀 Installation

### Prerequisites

- Arch Linux (or Arch-based distro)
- Internet connection
- Sudo privileges

### Quick Install

1. Clone or download this repository
2. Navigate to the directory
3. Run the setup script (choose one):

**Using Bash:**
```bash
chmod +x setup.sh
./setup.sh
```

**Using Fish:**
```bash
fish setup.fish
```

The script will:
- Update your system
- Install all required packages including SDDM
- Install Zen Browser from AUR
- Install yay if not present
- Install additional AUR packages
- Enable necessary services (NetworkManager, Bluetooth, PipeWire, SDDM)
- Copy all configuration files
- Set up SDDM with custom theme
- Set up fish shell as default
- Create startup scripts

### Manual Install

If you prefer manual installation:

1. Install required packages:
```bash
sudo pacman -S hyprland waybar kitty wofi fastfetch rofi-wayland swaybg swaylock wl-clipboard cliphist wayland xdg-wayland xdg-desktop-portal-wlr xdg-desktop-portal-gtk polkit-kde-agent dunst pavucontrol pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber bluez bluez-utils networkmanager brightnessctl playerctl thunar thunar-volman gvfs tumbler ffmpegthumbnailer fish neovim git base-devel unzip curl wget jq gtk3 gtk4 adwaita-icon-theme noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-jetbrains-mono ttf-font-awesome python-pywal sddm qt5-wayland qt6-wayland qt5-svg qt6-svg
```

2. Install AUR packages:
```bash
yay -S hyprpaper hyprpicker wlogout swww
```

3. Install Zen Browser:
```bash
cd /tmp
git clone https://github.com/zen-browser/desktop.git zen-browser
cd zen-browser
makepkg -si
```

4. Copy configuration files:
```bash
cp -r .config/hypr ~/.config/
cp -r .config/waybar ~/.config/
cp -r .config/fastfetch ~/.config/
cp -r .config/kitty ~/.config/
cp -r .config/wofi ~/.config/
cp -r .config/sddm ~/.config/
cp .local/share/backgrounds/boykisser.png ~/.local/share/backgrounds/
```

5. Set up SDDM theme:
```bash
sudo mkdir -p /usr/share/sddm/themes/boykisser
sudo cp background.png /usr/share/sddm/themes/boykisser/background.png
sudo cp .config/sddm/theme.conf /usr/share/sddm/themes/boykisser/theme.conf
sudo cp .config/sddm/Main.qml /usr/share/sddm/themes/boykisser/Main.qml
sudo mkdir -p /etc/sddm.conf.d
echo "[Theme]" | sudo tee /etc/sddm.conf.d/boykisser.conf
echo "Current=boykisser" | sudo tee -a /etc/sddm.conf.d/boykisser.conf
```

6. Enable services:
```bash
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth
sudo systemctl enable --now pipewire pipewire-pulse wireplumber
sudo systemctl enable sddm
```

7. Set fish as default shell:
```bash
chsh -s /usr/bin/fish
```

8. Reboot to start SDDM:
```bash
sudo reboot
```

## ⌨️ Keybindings

### System
- `SUPER + RETURN` - Open terminal
- `SUPER + D` - Open app launcher (wofi)
- `SUPER + W` - Open Zen Browser
- `SUPER + E` - Open file manager (Thunar)
- `SUPER + Q` - Close focused window
- `SUPER + SHIFT + Q` - Open power menu
- `SUPER + SHIFT + E` - Reload Hyprland config
- `SUPER + F` - Toggle floating
- `SUPER + P` - Toggle pseudo tiling
- `SUPER + J` - Toggle split
- `SUPER + T` - Toggle special workspace
- `SUPER + ESCAPE` - Lock screen
- `SUPER + S` - Screenshot (full screen)
- `SUPER + SHIFT + S` - Screenshot (selection)
- `SUPER + V` - Clipboard history
- `SUPER + L` - Lock screen
- `SUPER + B` - Restart Waybar
- `SUPER + SHIFT + B` - Kill Waybar
- `SUPER + R` - Open Neovim
- `SUPER + N` - Send notification
- `SUPER + O` - Open audio settings
- `SUPER + SHIFT + O` - Open Bluetooth settings

### Window Navigation
- `SUPER + LEFT/RIGHT/UP/DOWN` or `H/L/K/J` - Move focus
- `SUPER + SHIFT + LEFT/RIGHT/UP/DOWN` or `H/L/K/J` - Move window
- `SUPER + CTRL + LEFT/RIGHT/UP/DOWN` or `H/L/K/J` - Resize window

### Workspaces
- `SUPER + 1-0` - Switch to workspace
- `SUPER + SHIFT + 1-0` - Move window to workspace
- `SUPER + Mouse Scroll` - Cycle through workspaces

### Media Controls
- `XF86AudioRaiseVolume` - Volume up
- `XF86AudioLowerVolume` - Volume down
- `XF86AudioMute` - Toggle mute
- `XF86AudioPlay` - Play/Pause
- `XF86AudioNext` - Next track
- `XF86AudioPrev` - Previous track
- `XF86MonBrightnessUp` - Brightness up
- `XF86MonBrightnessDown` - Brightness down

## 🎨 Customization

### Colors
The theme uses pink/pastel colors throughout:
- Primary pink: `#FF69B4` (Hot Pink)
- Secondary pink: `#FFB6C1` (Light Pink)
- Lavender: `#DDA0DD` (Plum)
- Purple: `#DA70D6` (Orchid)
- Background: `#1E1E2E` (Dark)
- Foreground: `#F8F8F2` (Light)

You can customize these colors in:
- `.config/hypr/hyprland.conf` - Window borders
- `.config/waybar/style.css` - Bar styling
- `.config/kitty/kitty.conf` - Terminal colors
- `.config/wofi/style.css` - Launcher styling

### Wallpaper
Replace `.local/share/backgrounds/boykisser.png` with your preferred wallpaper.

### Fonts
The rice uses JetBrains Mono Nerd Font. Install additional fonts if needed:
```bash
sudo pacman -S ttf-jetbrains-mono-nerd
```

## 📁 Configuration Structure

```
.config/
├── hypr/
│   ├── hyprland.conf    # Hyprland configuration
│   └── start.sh         # Startup script
├── waybar/
│   ├── config           # Waybar modules
│   └── style.css        # Waybar styling
├── fastfetch/
│   └── config.jsonc     # Fastfetch configuration
├── kitty/
│   └── kitty.conf       # Terminal configuration
├── wofi/
│   ├── config           # Launcher settings
│   └── style.css        # Launcher styling
└── sddm/
    ├── theme.conf       # SDDM theme configuration
    └── Main.qml         # SDDM theme UI
```

## 🔧 Troubleshooting

### Zen Browser not opening
Make sure Zen Browser is installed:
```bash
zen-alpha
```

### Waybar not showing
Restart Waybar:
```bash
killall waybar && waybar &
```

### Wallpaper not setting
Restart swww:
```bash
killall swww && swww init && swww img ~/.local/share/backgrounds/boykisser.png
```

### Audio not working
Restart PipeWire:
```bash
systemctl --user restart pipewire pipewire-pulse wireplumber
```

### Bluetooth not working
Start Bluetooth service:
```bash
sudo systemctl start bluetooth
```

### SDDM not showing theme
Check if SDDM theme is installed:
```bash
ls /usr/share/sddm/themes/boykisser
```

If missing, reinstall the theme:
```bash
sudo mkdir -p /usr/share/sddm/themes/boykisser
sudo cp background.png /usr/share/sddm/themes/boykisser/background.png
sudo cp .config/sddm/theme.conf /usr/share/sddm/themes/boykisser/theme.conf
sudo cp .config/sddm/Main.qml /usr/share/sddm/themes/boykisser/Main.qml
```

Restart SDDM:
```bash
sudo systemctl restart sddm
```

### SDDM not starting
Check SDDM status:
```bash
sudo systemctl status sddm
```

If failed, enable and start:
```bash
sudo systemctl enable sddm
sudo systemctl start sddm
```

## 📸 Screenshots

Take a screenshot with:
- Full screen: `SUPER + S`
- Selection: `SUPER + SHIFT + S`

Screenshots are copied to clipboard. Paste with `SUPER + V` to access clipboard history.

## 🎯 Tips

1. **Customize keybindings** - Edit `.config/hypr/hyprland.conf`
2. **Add more apps** - Edit `.config/waybar/config` for bar modules
3. **Change animations** - Modify bezier curves in Hyprland config
4. **Add startup apps** - Edit `.config/hypr/start.sh`
5. **Monitor performance** - Use Waybar's CPU/Memory modules

## 🌟 Credits

- **Hyprland** - Dynamic tiling Wayland compositor
- **Waybar** - Highly customizable Wayland bar
- **Kitty** - Fast, feature-rich GPU terminal
- **Wofi** - Launcher for Wayland
- **Zen Browser** - Privacy-focused browser
- **Fastfetch** - Neofetch replacement
- **Arch Linux** - The amazing base

## 💖 Support

If you encounter any issues or have suggestions, feel free to:
- Open an issue
- Make a pull request
- Share your customizations

Enjoy your cute femboy boykisser rice! 🌸💖
