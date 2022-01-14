#!/bin/bash

# Creates a custom terminal command for boilApp to be used anywhere in the terminal.

function saveCmd {
  touch .boilApp.sh
  # copy boilApp.sh into .boilApp.sh
  # move boilApp.sh to home directory
  # change to /etc
  # add source ~/.boilApp.sh to zshrc file
  echo "Terminal command created\nType 'boilApp' to use"
}

saveCmd
