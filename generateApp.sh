#!/bin/bash

# Produces a full stack application with React, Express/Node, MongoDB

function writeBabelRC {
  babelRCLines='{\n\t"presets": [\n\t\t"@babel/preset-env", \n\t\t"@babel/preset-react"\n\t]\n}'
  echo $babelRCLines >> .babelrc
}

function iterativeWrite {
  lines=("$@")
  for line in "${lines[@]}"; do
    echo $line >> $1
  done
}

function writeServer {
  constRequires=(
    "const express = require('express');"
    "const path = require('path');"
    "const MongoClient = require('mongodb').MongoClient;"
    "const port = process.env.PORT || 9100;"
    "const app = express();"
    ""
    "// const uri = require('keyconfig').MongoURI;"
    "// const client = new MongoClient(uri, { useNewUrlParser: true })"
    ""
  )

  dbConnection=(
    "// async function connectToDB() {"
    "// \tawait client.connect( err => {"
    "// \t\terr ? console.log(err) : console.log('Connected to database');"
    "// \t});"
    "// }"
    "// connectToDB();"
    ""
  )

  appMethods=(
    "const pathToBuild = path.join(__dirname, 'build');"
    "app.use(bodyParser.urlencoded({ extended: true }));"
    "app.use(express.static(pathToBuild));"
    "app.get('/', (req, res) => {"
    "\tres.sendFile(pathToBuild, 'index.html');"
    "});"
    "app.listen(port, () => console.log('Listening on ' + port));"
  )

  iterativeWrite server.js "${constRequires[@]}"
  iterativeWrite server.js "${dbConnection[@]}"
  iterativeWrite server.js "${appMethods[@]}"
}

function writeWebpackConfig {
  echo "const path = require('path');
const HtmlWebPackPlugin = require('html-webpack-plugin');

module.exports = {
  mode: 'development',
  output: {
    path: path.resolve(__dirname, 'build'),
    filename: 'bundle.js'
  },
  resolve: {
    modules: [path.join(__dirname, 'src'), 'node_modules'],
    alias: {
      react: path.join(__dirname, 'node_modules', 'react')
    }
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        },
      },
      {
        test: /\.css/,
        use: [
          {
            loader: 'style-loader'
          },
          {
            loader: 'css-loader'
          }
        ]
      }
    ]
  },
  plugins: [
    new HtmlWebPackPlugin({
      template: './src/index.html'
    })
  ],
  devServer: {
    port: 9000,
    hot: true
  }
}" >> webpack.config.js
}

function writeConfig {
  keyConfig=(
    "module.exports = {"
    "\tMongoURI: 'mongodb+srv://user:password@cluster0.0wmx5.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'"
    "}"
  )

  authConfig=(
    "module.exports = {"
    "\tensureAuthenticated: function(req, res, next) {"
    "\t\tif (req.isAuthenticated()) {"
    "\t\t\treturn next();"
    "\t\t}"
    "\t}"
    "}"
  )

  passportConfig=(
    "const LocalStrategy = require('passport-local').Strategy;"
    "const bcrypt = require('bcrypt');"
    "const mongoose = require('mongoose');"
    "const User = require('../models/user');"
    ""
    "module.exports = {"
    "\tinitPassport = function(passport) {"
    "\t\tpassport.use("
    "\t\t\tnew LocalStrategy({ usernameField: 'email' }, (req, res, done) => {"
    "\t\t\t\tUser.findOne(user)"
    "\t\t\t\t\t.then(user => {"
    "\t\t\t\t\t\tif(!user) {"
    "\t\t\t\t\t\t\treturn done(null, false, { message: 'Invalid email'});"
    "\t\t\t\t\t\t}"
    "\t\t\t\t\t\tbcrypt.compare(password, user.password, (err, isMatch) => {"
    "\t\t\t\t\t\t\tif (err) throw err;"
    "\t\t\t\t\t\t\tif (isMatch) {"
    "\t\t\t\t\t\t\t\treturn done(null, user);"
    "\t\t\t\t\t\t\t} else {"
    "\t\t\t\t\t\t\t\t return done(null, false, { message: 'Incorrect password'});"
    "\t\t\t\t\t\t\t}"
    "\t\t\t\t\t\t});"
    "\t\t\t\t\t})"
    "\t\t\t\t\t.catch(err => console.log(err));"
    "\t\t\t})"
    "\t\t);"
    ""
    "\t\tpassport.serializeUser((user, done) => {"
    "\t\t\tdone(null, user.id);"
    "\t\t});"
    ""
    "\t\tpassport.deserializeUser((id, done) => {"
    "\t\t\tUser.findById(id, (err, user) => {"
    "\t\t\t\tdone(err, user);"
    "\t\t\t})"
    "\t\t})"
    "\t}"
    "}"
  )

  iterativeWrite config/keys.js "${keyConfig[@]}"
  iterativeWrite config/auth.js "${authConfig[@]}"
  iterativeWrite config/passport.js "${passportConfig[@]}"
}

function writeSrc {
  indexHTML=(
    '<!DOCTYPE html>'
    '<html lang="en">'
    '<head>'
    '\t<meta charset="UTF-8">'
    '\t<meta name="viewport" content="width=device-width, initial-scale=1">'
    '\t<title>MERN App</title>'
    '</head>'
    '<body>'
    '\t<div id="root"></div>'
    '</body>'
    '</html>'
  )

  indexJS=(
    "import React from 'react';"
    "import { render } from 'react-dom';"
    "import App from './app';"
    ""
    "render(<App />, document.getElementById('root'));"
  )

  appJS=(
    "const App = () => {"
    "\treturn ("
    "\t\t<h1>Awesome frontend here! If you see this, you're doing great.</h1>"
    "\t)"
    "}"
    ""
    "export default App;"
  )

  iterativeWrite src/index.html "${indexHTML[@]}"
  iterativeWrite src/index.js   "${indexJS[@]}"
  iteartiveWrite src/app.js     "${appJS[@]}"
}

function updatePackageJSON {
  sed -i.bak '7i\
  \    "start": "node server",\
  \    "build": "webpack --mode=production",\
  \    "devf": "webpack serve --open --hot",\
  \    "devb": "webpack --mode=production && nodemon server",\
  ' package.json

  rm package.json.bak
}

function writeRoutes {
  echo "writing routes/index.js"
}

function writeFiles {
  writeBabelRC
  writeServer
  writeWebpackConfig
  writeConfig
  writeSrc
  writeRoutes
  writeModels
  updatePackageJSON
  echo "Finished writing files"
}

function generateApp {
  echo "Setting up MERN app with npm..."
  npm init -y

  dependencies=(
    react react-dom express express-session cookie-parser
    passport passport-local mongoose
  )

  devDependencies=(
    @babel/core @babel/preset-env @babel/preset-react
    babel-loader css-loader style-loader html-webpack-plugin
    webpack webpack-cli webpack-dev-server regenerator-runtime
  )

  function iterativeInstall {
    dependencyList=("$@")
    for d in "${dependencyList[@]}"; do
      npm install $d --save$1
    done
  }

  iterativeInstall ""     "${dependencies[@]}"
  iterativeInstall "-dev" "${devDependencies[@]}"

  directories=( build public src config models routes src/components)

  for di in "${directories[@]}"; do
    mkdir $di
  done

  srcFiles=( app.js index.js style.css index.html )
  configFiles=( keys.js passport.js auth.js )
  globalFiles=( server.js webpack.config.js .babelrc .gitignore )

  function createFiles() {
    files=("$@")
    for f in "${files[@]}"; do
      if [ "$1" == "" ] ; then
        touch "$f"
      elif [ "$1" != "$f" ] ; then
        touch "$1"/"$f"
      fi
    done
  }

  createFiles "" "${globalFiles[@]}"
  createFiles "config" "${configFiles[@]}"
  createFiles "src" "${srcFiles[@]}"
  touch routes/index.js
  touch models/user.js

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
  echo "Writing files..."

  writeFiles

  echo "Finished writing files"
  echo "Application setup complete"
}

generateApp $1 # main
