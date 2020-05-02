#!/usr/bin/env bash

PS3="Please select an option: "
select opt in packages config fonts quit
do
  case $opt in
    "packages")
      ./"$opt".sh
      break
      ;;
    "config")
      ./"$opt".sh
      break
      ;;
    "fonts")
      ./"$opt".sh
      break
      ;;
    "quit")
      printf 'Quitting...\n'
      break
      ;;
    *) printf 'Invalid option: %s \n' "$REPLY";;
  esac
done
