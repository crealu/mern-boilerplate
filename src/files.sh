#!/bin/bash

# Fill all files with starter code

source ./src/write/writeConfig.sh
source ./src/write/writeServer.sh
source ./src/write/writeSource.sh
source ./src/write/writePackage.sh

function writeFiles {
  writeConfigFiles
  writeServerFile
  writeSourceFiles
  updatePackageJSON
  echo "Finished writing files"
}
