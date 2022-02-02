#!/bin/bash

# Creates the application structure of folders and files

function createStructure {
  directories=( build public src config)
  globalFiles=( server.js webpack.config.js keyconfig.js .babelrc .gitignore )
  srcFiles=( app.js index.js style.css index.html )

  for di in "${directories[@]}"; do
    mkdir $di
  done

  for gf in "${globalFiles[@]}"; do
    touch $gf
  done

  for sf in "${srcFiles[@]}"; do
    touch src/$sf
  done

  if [ $# -eq 0 ]
    then
      echo "Initialized with basic file structure"
  elif [ $1 = "--bfs" ]
    then
      echo "Initialized with backend file structure"
      mkdir config
      mkdir models
      mkdir routes
      mkdir views

      configfiles=( keys.js passport.js auth.js )
      for cf in "${configFiles[@]}"; do
        touch config/$cf
      done

      touch models/user.js
      touch routes/index.js

      viewFiles=( index.ejs signup.ejs login.ejs )
      for vf in "${viewFiles[@]}"; do
        touch views/$vf
      done
  fi

  echo "Finished generating configuration and source files"
}
