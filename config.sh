#!/usr/bin/env bash

configure_docker() {
  read -r -p "Manage Docker as a non-root user? [y/N] " answer
  if [[ "$answer" == y ]] || [[ "$answer" == Y ]]; then
    printf "\nAdding 'docker' group..."
    sudo groupadd docker

    printf '\nAdding user %s to docker group...' "$USER"
    sudo usermod -aG docker "$USER"

    printf "Done.\n"
  fi
}

configure_npm() {
  read -r -p "Manage NPM as a non-root user? [y/N] " answer
  if [[ "$answer" == y ]] || [[ "$answer" == Y ]]; then
    local npm_dir="$HOME/.npm-global"

    if [[ ! -d "$npm_dir" ]]; then
        printf '\nCreating dir %s...\n' "$npm_dir"
        mkdir -p "$npm_dir"
    else
        printf '\nDirectory %s exists...\n' "$npm_dir"
    fi

    printf '\nAdding to %s npm config...' "$npm_dir"
    npm config set prefix "$HOME/.npm-global"
    printf "Done.\n"
  fi
}

configure_gnome() {
  read -r -p "Configure Gnome 3 look ? [y/N] " answer
  if [[ "$answer" == y ]] || [[ "$answer" == Y ]]; then
    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
    gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
    gsettings set org.gnome.desktop.interface enable-hot-corners false

    gsettings set org.gnome.desktop.interface clock-show-date true
    gsettings set org.gnome.desktop.interface clock-show-seconds false
    gsettings set org.gnome.desktop.interface clock-show-weekday false

    gsettings set org.gnome.desktop.interface document-font-name 'Inter 11'
    gsettings set org.gnome.desktop.interface font-name 'Inter 11'
    gsettings set org.gnome.desktop.interface monospace-font-name 'Inter 11'

    gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize:'

    gsettings set org.gnome.desktop.wm.keybindings close "['<Control>q']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>Left']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>Right']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Shift><Super>Left']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Super>Right']"

    gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Control><Super>Left']"
    gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Control><Super>Right']"

    printf "Done.\n"
  fi
}

configure_zsh() {
  read -r -p "Configure zsh as default shell ? [y/N] " answer
  if [[ "$answer" == y ]] || [[ "$answer" == Y ]]; then
    chsh -s $(which zsh)
  fi
  
  read -r -p "Install Oh-My-Zsh ? [y/N] " answer
  if [[ "$answer" == y ]] || [[ "$answer" == Y ]]; then
    sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
  fi
}

configure_docker
configure_npm
configure_gnome
configure_zsh

printf "Configuration completed.\n"
