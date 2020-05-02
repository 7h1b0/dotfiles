#!/usr/bin/env bash

install_packages() {
  read -r -p "Add packages ? [y/N] " answer
  if [[ "$answer" == y ]] || [[ "$answer" == Y ]]; then
    packages=(
      "gnome-tweaks"
      "filezilla"
      "geary"
      "mumble"
      "restic"
      "zsh"
      "mkvtoolnix"
      "mkvtoolnix-gui"
      "papirus-icon-theme"
      "spotify-client"
      "git"
      "codium"
      "npm"
      "nodejs"
      "docker.io"
      "docker-compose"
      "insomnia"
    )

    sudo apt update
    sudo apt install "${packages[@]}"
    printf "Done.\n"
  fi
}

remove_packages() {
  read -r -p "Remove packages ? [y/N] " answer
  if [[ "$answer" == y ]] || [[ "$answer" == Y ]]; then
    packages=(
      "gnome-games"
      "gnome-maps"
      "gnome-software"
      "gnome-todo"
      "gnome-weather"
      "gnome-music"
      "rhythmbox"
      "cheese"
      "gnome-documents"
      "vinagre"
      "gnome-clocks"
      "shotwell"
      "gnome-sound-recorder"
      "gnome-contacts"
      "seahorse"
      "gnome-calendar"
      "evolution"
    )

    sudo apt autoremove --purge "${packages[@]}"
    printf "Done.\n"
  fi
}

source_packages() {
  read -r -p "Add sources ? [y/N] " answer
  if [[ "$answer" == y ]] || [[ "$answer" == Y ]]; then
    printf 'Adding vscodium source...\n'
    wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -
    echo 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list

    printf 'Adding Insomnia source...\n'
    wget -qO - https://insomnia.rest/keys/debian-public.key.asc | sudo apt-key add -
    echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" | sudo tee /etc/apt/sources.list.d/insomnia.list

    printf 'Adding Mkvtoolnix source...\n'
    wget -qO - https://mkvtoolnix.download/gpg-pub-moritzbunkus.txt | sudo apt-key add -
    echo "deb https://mkvtoolnix.download/debian/ buster main" | sudo tee /etc/apt/sources.list.d/mkvtoolnix.list 

    printf 'Adding Spotify source...\n'
    wget -qO - https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

    printf "Done.\n"
  fi
}

remove_packages
source_packages
install_packages
