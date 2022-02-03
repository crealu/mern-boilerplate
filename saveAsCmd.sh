#!/bin/bash

# Creates a custom terminal command for boilApp to be used anywhere in the terminal.

function saveCmd {
  # copy boilApp.sh into .boilApp.sh
  cp boilAppSkel.sh .boilAppSkel.sh

  # comment out boilApp function call
  sed -i.bak '/boilApp # main/d' .boilAppSkel.sh

  # delete backup file
  rm .boilAppSkel.sh.bak

  # move .boilApp.sh to home directory
  mv .boilAppSkel.sh ~/

  # change to /etc
  cd ~ && cd .. && cd ../etc

  # add source ~/.boilApp.sh to zshrc file
  echo '\nsource ~/.boilAppSkel.sh' >> zshrc

  # notify user
  echo "\nTerminal command created\nType 'boilApp' to use"
}

saveCmd
