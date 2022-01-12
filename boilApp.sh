#!/bin/bash

# Produces a full stack application with React, Express/Node, MongoDB

function writeBabelRC {
  str='{\n\t"presets": [\n\t\t"@babel/preset-env", \n\t\t"@babel/preset-react"\n\t]\n}'
  echo $str >> .babelrc
}

function writeServerJS {
  constRequires=(
    "const express = require('express');"
    "const bodyParser = require('body-parser');"
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
    "async function connectToDB() {"
    "\tawait client.connect( err => {"
    "\t\terr ? console.log(err) : console.log('Connected to database');"
    "\t});"
    "}"
    "connectToDB();"
    ""
    "const pathToBuild = path.join(__dirname, 'build');"
    ""
  )

  appMethods=(
    "app.use(bodyParser.urlencoded({ extended: true }));"
    "app.use(express.static(pathToBuild));"
    "app.get('/', (req, res) => {"
    "\tres.sendFile(pathToBuild, 'index.html');"
    "});"
    "app.listen(port, () => console.log('Listening on ' + port));"
  )

  for const in "${constRequires[@]}"; do
    echo $const >> server.js
  done

  for cdb in "${dbConnection[@]}"; do
    echo $cdb >> server.js
  done

  for am in "${appMethods[@]}"; do
    echo $am >> server.js
  done
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

function writeKeyConfig {
  kConfig=(
    "module.exports = {"
    "\tMongoURI: 'mongodb+srv://user:password@cluster0.0wmx5.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'"
    "}"
  )
  for kc in "${kConfig[@]}"; do
    echo $kc >> keyconfig.js
  done
}

function writeSrcFiles {
  echo '
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>MERN App</title>
  </head>
  <body>
    <div id="root"></div>
  </body>
  </html>' >> src/index.html

  echo "
  import React from 'react';
  import { render } from 'react-dom';
  import App from './app';

  render(<App />, document.getElementById('root'));" >> src/index.js

  echo "
const App = () => {
  return (
    <h1>Awesome frontend here! If you see this, you're doing great.</h1>
  )
}

export default App;" >> src/app.js
}

function updatePackageJSON {
  sed -i.bak '7i\
  \    "start": "node server",\
  \    "build": "webpack --mode=production",\
  \    "devf": "webpack serve --open --hot",\
  \    "devb": "webpack --mode=production && nodemon server",\
  ' package.json
}

function writeFiles {
  # writeBabelRC
  writeServerJS
  # writeWebpackConfig
  # writeKeyConfig
  # writeSrcFiles
  # updatePackageJSON
  echo "Finished writing files"
}

function boilApp {
  echo "Setting up full stack (MERN) app with npm..."

  dependencies=( react react-dom express mongodb body-parser )
  devDependencies=(
    @babel/core @babel/preset-env @babel/preset-react
    babel-loader css-loader style-loader
    webpack webpack-cli webpack-dev-server html-webpack-plugin
  )

  npm init -y

  for d in "${dependencies[@]}"; do
    npm install $d --save
  done

  for dd in "${devDependencies[@]}"; do
    npm install $dd --save-dev
  done

  echo "Finished installing dependencies"
  echo "Generating configuration and source files..."

  directories=( build public src )
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

  echo "Finished generating configuration and source files"
  echo "Writing files..."

  writeFiles

  echo "Finished writing files"
  echo "Application setup completed"
}

# boilApp

writeFiles
