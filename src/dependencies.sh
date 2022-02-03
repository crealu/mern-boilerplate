#!/bin/bash

# Installs dependencies
function installDependencies {
  dependencies=(
    react                     bcrypt
    react-dom                 express
    express                   express-session
    mongodb                   cookie-parser
    body-parser               passport
    ejs                       passport-local
    nodemailer
  )
  
  devDependencies=(
    @babel/core               style-loader
    @babel/preset-env         webpack
    @babel/preset-react       webpack-cli
    babel-loader              webpack-dev-server
    css-loader                html-webpack-plugin
    nodemon
  )

  for d in "${dependencies[@]}"; do
    npm install $d --save
  done

  for dd in "${devDependencies[@]}"; do
    npm install $dd --save-dev
  done

  echo "Finished installing dependencies"
}
