#!/bin/bash

# Creates the application structure of folders and files

function createFileStructure {
  echo "Initialized with backend file structure"
  directories=( build public src config models views routes)
  srcFiles=( app.js index.js style.css index.html )
  configFiles=( keys.js passport.js auth.js )
  viewFiles=( index.ejs signup.ejs login.ejs resetPassword.ejs )
  globalFiles=( server.js webpack.config.js .babelrc .gitignore )

  for di in "${directories[@]}"; do
    mkdir $di
  done

  function createFiles() {
    files=("$@")
    for f in "${files[@]}"; do
      if [ "$1" == "" ] ; then
        echo "$f"
      elif [ "$1" != "$f" ] ; then
        echo "$1"/"$f"
      fi
    done
  }

  createFiles "" "${globalFiles[@]}"
  createFiles "config" "${configFiles[@]}"
  createFiles "views" "${viewFiles[@]}"
  createFiles "src" "${srcFiles[@]}"

  touch models/user.js
  touch routes/index.js
  touch routes/email.js

  echo "Finished generating configuration and source files"
}
