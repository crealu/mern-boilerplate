#!/bin/bash

# Produces a full stack application comprised of React, Express, Node, MongoDB

source ./dependencies.sh
source ./structure.sh
source ./files.sh

function initApplication {
  echo "Setting up full stack (MERN) app with npm..."

  npm init -y
  installDependencies
  createStructure $1
  writeFiles

  echo "Application setup complete"
}

initApplication $1
