#!/bin/bash

# Installs dependencies
function installDependencies {
  dependencies=( react react-dom express mongodb body-parser )
  devDependencies=(
    @babel/core
    @babel/preset-env
    @babel/preset-react
    babel-loader
    css-loader
    style-loader
    webpack
    webpack-cli
    webpack-dev-server
    html-webpack-plugin
  )

  for d in "${dependencies[@]}"; do
    npm install $d --save
  done

  for dd in "${devDependencies[@]}"; do
    npm install $dd --save-dev
  done

  echo "Finished installing dependencies"
}
