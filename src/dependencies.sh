#!/bin/bash

# Installs dependencies

function installDependencies {
  dependencies=(
    react                     bcrypt
    react-dom                 express
    cookie-parser             express-session
    body-parser               passport
    ejs                       passport-local
    nodemailer                mongoose
  )

  devDependencies=(
    @babel/core               nodemon
    @babel/preset-env         webpack
    @babel/preset-react       webpack-cli
    babel-loader              webpack-dev-server
    css-loader                html-webpack-plugin
    style-loader
  )

  for d in "${dependencies[@]}"; do
    npm install $d --save
  done

  for dd in "${devDependencies[@]}"; do
    npm install $dd --save-dev
  done

  echo "Finished installing dependencies"
}
