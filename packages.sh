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
      "rclone"
      "zsh"
      "ffmpeg"
      "papirus-icon-theme"
      "spotify-client"
      "git"
      "codium"
      "nodejs"
      "npm"
      "abiword"
      "gnumeric"
      "gimp"
      "transmission"
      "syncthing"
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
      "libreoffice-core"
      "libreoffice-common"
      "simple-scan"
      "malcontent"
    )

    sudo apt autoremove --purge "${packages[@]}"
    printf "Done.\n"
  fi
}

source_packages() {
  read -r -p "Add sources ? [y/N] " answer
  if [[ "$answer" == y ]] || [[ "$answer" == Y ]]; then
    printf 'Adding vscodium source...\n'
    wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg
    echo 'deb [signed-by=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list

    printf 'Adding Spotify source...\n'
    wget -qO - https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

    printf 'Adding Syncthing source...\n'
    sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

    printf "Done.\n"
  fi
}

remove_packages
source_packages
install_packages
