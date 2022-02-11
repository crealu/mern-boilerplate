#!/bin/bash

function createTerminalCommand {
  cp boilApp.sh .boilApp.sh
  sed -i.bak '/boilApp # main/d' .boilApp.sh
  rm .boilApp.sh.bak
  mv .boilApp.sh ~/

  cd ~ && cd .. && cd ../etc

  echo '\nsource ~/.boilAppSkel.sh' >> zshrc
  echo "\nTerminal command created\nType 'boilApp' to use"
}

createTerminalCommand
