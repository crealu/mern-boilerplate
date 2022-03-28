#!/bin/bash

function createTerminalCommand {
  cp generateApp.sh .generateApp.sh
  sed -i.bak '/generateApp # main/d' .generateApp.sh
  rm .generateApp.sh.bak
  mv .generateApp.sh ~/

  cd ~ && cd .. && cd ../etc

  echo '\nsource ~/.generateApp.sh' >> zshrc
  echo "\nTerminal command created\nType 'generateApp' to use"
}

createTerminalCommand
