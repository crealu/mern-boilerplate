#!/bin/bash

function writeServerFile {
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
