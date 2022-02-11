#!/bin/bash

# Installs dependencies

function loopAndInstall {
  dependencyList=("$@")
  for d in "${dependencyList[@]}"; do
    npm install $d --save$1
  done
}

function installDependencies {
  dependencies=(
    react                     bcrypt
    react-dom                 express
    cookie-parser             express-session
    passport                  passport-local
    ejs                       mongoose
    nodemailer
  )

  devDependencies=(
    @babel/core               nodemon
    @babel/preset-env         webpack
    @babel/preset-react       webpack-cli
    babel-loader              webpack-dev-server
    css-loader                html-webpack-plugin
    style-loader
  )

  loopAndInstall ""  "${dependencies[@]}"
  loopAndInstall "-dev" "${devDependencies[@]}"

  echo "Finished installing dependencies"
}
