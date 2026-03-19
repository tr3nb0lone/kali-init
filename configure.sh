#!/usr/bin/env bash

# forces overwriting of existing configs:
alias cp='cp -f'

echo -e "\n[INFO] Script initialized!\n"
home=${HOME}

# INFO: essentials!
sudo apt update
sudo apt-get install -y wget curl git thunar
sudo apt-get install -y arandr flameshot arc-theme feh i3blocks i3status i3 i3-wm lxappearance python3-pip rofi unclutter cargo compton papirus-icon-theme imagemagick
sudo apt-get install -y libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf meson
sudo apt-get install -y libxcb-render-util0-dev libxcb-shape0-dev libxcb-xfixes0-dev

# drop dotfiles the lazy way!
cp ./dotfiles/* "$home/.config"
cp ./aliases ~/.zsh_aliases

cd "$home" || exit

echo -e "[INFO] Onto Installing nvim:\n"
# clean previous config/cache, then install
rm -rf ~/.config/nvim
rm -rf ~/.cache/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
git clone https://github.com/tr3nb0lone/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

# favorite fonts:
mkdir -p ~/.local/share/fonts/
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip
unzip Iosevka.zip -d ~/.local/share/fonts/
fc-cache -fv # whoa!

cd "$home" || exit

# terminal essentials:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/RyanMacG/tpm-redux.git ~/.tmux/plugins/tpm-redux

echo -e "[INFO] setup is ready!"
sudo reboot
