#!/bin/bash

# Produces a full stack application comprised of React, Express, Node, MongoDB

source ./src/dependencies.sh
source ./src/structure.sh
source ./src/files.sh

function initApplication {
  echo "Setting up full stack (MERN) app with npm..."

  npm init -y
  installDependencies
  createStructure
  writeFiles

  echo "Application setup complete"
}
