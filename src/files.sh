#!/bin/bash

# Fill all files with starter code

source ./src/write/writeConfig.sh

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
  indexHTML=(
    '<!DOCTYPE html>'
    '<html lang="en">'
    '<head>'
    '\t<meta charset="UTF-8">'
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

  for ih in "${indexHTML[@]}"; do
    echo $ih >> src/index.html
  done

  for ijs in "${indexJS[@]}"; do
    echo $ijs >> src/index.js
  done

  for ajs in "${appJS[@]}"; do
    echo $ajs >> src/app.js
  done
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

function writeFiles {
  writeBabelRC
  writeServerJS
  writeWebpackConfig
  writeKeyConfig
  writeSrcFiles
  updatePackageJSON
  echo "Finished writing files"
}
