#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo pacman -S \
  the_silver_searcher \
  awless \
  fzf \
  go \
  docker \
  docker-compose \
  neo-fetch \
  xsel \
  fzf \
  keybase \
  kbfs \
  ttf-fira-code \
  diff-so-fancy


sudo pacman -R palemoon-bin
