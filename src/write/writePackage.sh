#!/bin/bash

function updatePackageJSON {
  sed -i.bak '7i\
  \    "start": "node server",\
  \    "build": "webpack --mode=production",\
  \    "devf": "webpack serve --open --hot",\
  \    "devb": "webpack --mode=production && nodemon server",\
  ' package.json

  rm package.json.bak
}
