#!/usr/bin/env bash


# forces overwriting of existing configs:
alias cp='cp -f'

echo -e "\t Script initialized!\n"
home=${HOME}

# INFO: essentials!
sudo apt update
sudo apt-get install -y wget curl git thunar
sudo apt-get install -y arandr flameshot arc-theme feh i3blocks i3status i3 i3-wm lxappearance python3-pip rofi unclutter cargo compton papirus-icon-theme imagemagick
sudo apt-get install -y libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf meson
sudo apt-get install -y libxcb-render-util0-dev libxcb-shape0-dev libxcb-xfixes0-dev

# prepare the destination directories:
echo -e "\t Now creating the destination directories:\n"
config_dirs=(
    "i3"
    "feh"
    "utils"
    "i3-autodisplay"
    "picom"
    "kitty"
    "tmux"
    "polybar"
    "rofi"
    "dunst"
    "wallpapers"
    "yazi"
)

for dir in "${config_dirs[@]}"; do
    mkdir -p "$home/.config/$dir/" || echo -e "$dir already exists. boohoo.\n"
done

# list of dotfiles and destinations
echo -e "\t Copying the dotfiles onto their respective destination:\n"
declare -A dotfiles=(
    ["./dotfiles/dunst/"]=".config/dunst/"
    ["./dotfiles/feh/"]=".config/feh/"
    ["./dotfiles/ghostty/"]=".config/ghostty/"
    ["./dotfiles/i3/"]=".config/i3/"
    ["./dotfiles/i3-autodisplay/"]=".config/i3-autodisplay/"
    ["./dotfiles/kitty/"]=".config/kitty/"
    ["./dotfiles/polybar/"]=".config/polybar/"
    ["./dotfiles/picom/"]=".config/picom/"
    ["./dotfiles/rofi/"]=".config/rofi/"
    ["./dotfiles/tmux/"]=".config/tmux/"
    ["./dotfiles/utils/"]=".config/utils/"
    ["./dotfiles/wallpapers/"]=".config/wallpapers/"
    ["./dotfiles/yazi/"]=".config/yazi/"
    ["./dotfiles/aliases"]=".zsh_aliases"
)

# copy each dotfile to its destination
for src in "${!dotfiles[@]}"; do
    dest="$home/${dotfiles[$src]}"
    cp -rf "$src" "$dest"
done

cd "$home" || exit

echo -e "\t Now cloning TPM-redux:\n"
git clone https://github.com/RyanMacG/tpm-redux.git ~/.tmux/plugins/tpm-redux

# Volume Control
cd "$home" || exit
git clone https://github.com/hastinbe/i3-volume.git ~/i3-volume

# nvim
echo -e "\t Onto Installing Nvim:\n"
# clean previous config/cache:
rm -rf ~/.config/nvim
rm -rf ~/.cache/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim

# replace it with my own
git clone https://github.com/tr3nb0lone/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

# fonts:
mkdir -p ~/.local/share/fonts/

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip

unzip Iosevka.zip -d ~/.local/share/fonts/
unzip RobotoMono.zip -d ~/.local/share/fonts/

fc-cache -fv

# install ohMyZsh:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "setup is ready!"
sudo reboot
