#!/usr/bin/env bash

copy_fonts() {
  src="$1"
  dest="$2"
  work_dir="$PWD/$src"

  if [[ ! -d "$dest" ]]; then
    printf 'Directory "%s" does not exist.\n' "$dest"
    printf 'Creating directory "%s"...\n' "$dest"
    sudo mkdir -p "$dest"
  fi

  for font_dir in $work_dir/*; do
    if [[ -d $font_dir ]]; then
      printf 'Copying "%s"...\n' "$font_dir"
      cp -r "$font_dir" "$dest/"
    fi
  done
}

setup_fonts() {
  printf "Setting up fonts...\n"

  base_dir="fonts"
  local_dest="$HOME/.local/share/fonts"

  copy_fonts "$base_dir" "$local_dest"

  printf "Done.\n"
}

setup_fonts
