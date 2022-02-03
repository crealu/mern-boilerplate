#!/bin/bash

# Produces a full stack application with React, Express/Node, MongoDB

source ./src/dependencies.sh
source ./src/structure.sh
source ./src/files.sh

function initApplication {
  echo "Setting up full stack (MERN) app with npm..."
  d=( hello hey sup )
  f=( oy me ha do )

  function forList {
    arr=("$@")
    for l in $arr; do
      echo $l
    done
  }
  forList "${d[@]}"

  # npm init -y
  # installDependencies
  # createStructure
  # writeFiles

  echo "Application setup complete"
}

initApplication
