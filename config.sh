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
    gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize:'

    gsettings set org.gnome.desktop.background picture-options 'zoom'
    gsettings set org.gnome.desktop.background picture-uri "file://"$PWD"//Wallpaper.jpg"
    printf "Done.\n"
  fi
}

configure_docker
configure_npm
configure_gnome

printf "Configuration completed.\n"
