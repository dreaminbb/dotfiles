#!/bin/bash

process_name=$1

case "$process_name" in
  *nvim*)
    echo " nvim"
    ;;
  *lazygit*)
    echo " lazygit"
    ;;
  *docker*)
    echo " docker"
    ;;
  *gemini*)
    echo " gemini"
    ;;
  *zsh*|*bash*|*fish*)
    echo " shell"
    ;;
  *)
    echo " $process_name"
    ;;
esac
