#!/bin/bash

# Creates the application structure of folders and files

function createStructure {
  globalFiles=( server.js webpack.config.js .babelrc .gitignore )
  for gf in "${globalFiles[@]}"; do
    touch $gf
  done

  if [ $# -eq 0 ]
    then
      echo "Initialized with basic file structure"
      directories=( build public src )
      srcFiles=( app.js index.js style.css index.html )

      for di in "${directories[@]}"; do
        mkdir $di
      done

      for sf in "${srcFiles[@]}"; do
        touch src/$sf
      done
  elif [ $1 = "--bfs" ]
    then
      echo "Initialized with backend file structure"
      directories=( build public src config models views routes)
      configfiles=( keys.js passport.js auth.js )
      viewFiles=( index.ejs signup.ejs login.ejs resetPassword.ejs )

      for di in "${directories[@]}"; do
        mkdir $di
      done

      for cf in "${configFiles[@]}"; do
        touch config/$cf
      done

      for vf in "${viewFiles[@]}"; do
        touch views/$vf
      done

      touch models/user.js
      touch routes/index.js
      touch routes/email.js
  fi

  echo "Finished generating configuration and source files"
}
