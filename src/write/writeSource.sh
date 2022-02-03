#!/bin/bash

function writeSourceFiles {
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
