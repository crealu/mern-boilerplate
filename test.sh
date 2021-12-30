#!/bin/bash

function writeBabelRC {
  str='{\n\t"presets": [\n\t\t"@babel/preset-env", \n\t\t"@babel/preset-react"\n\t]\n}'
  echo $str > test.txt
}

function writeServerJS {
  consts=( express bodyParser path MongoClient uri
    port app client)
  requires=( express body-parser path mongodb keyconfig
    "process.env.PORT || 9000" "express()" "new MongoClient(uri)")
  n=0
  for c in "${consts[@]}"; do
    mainstr="const "$c" = require('"${requires[n]}"')"
    mainstr2="const "$c" = "${requires[n]}
    if [ "$n" -eq 3 ]; then
      mainstr="${mainstr}.MongoClient"
    elif [ "$n" -eq 4 ]; then
      mainstr="${mainstr}.MongoURI"
    fi

    if [ "$n" -gt 4 ]; then
      echo "${mainstr2};" >> test.txt
    else
      echo "${mainstr};" >> test.txt
    fi

    n=$((n + 1))
  done

  echo "\nasync function connectToDB() {\n\tawait client.connect( err => {
    err ? console.log(err) : console.log('Connected to database');
  });\n}" >> test.txt
  echo "connectToDB();" >> test.txt
  echo "\nconst pathToBuild = path.join(__dirname, 'build');\n" >> test.txt

  appMethods=(
    "app.use(bodyParser.urlencoded({ extended: true }));"
    "app.use(express.static(pathToBuild));"
    "app.get('/', (req, res) => {
      res.sendFile(pathToBuild, 'index.html');
    });"
    "app.listen(port, () => console.log('Listening on ' + port));"
  )

  for am in "${appMethods[@]}"; do
    echo $am >> test.txt
  done
}

function writeWebpackConfig {
  echo "const path = require('path');
const HtmlWebPackPlugin = require('html-webpack-plugin');

module.exports = {
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
    port: 9000
  }
}" >> test.txt
}

function writeKeyConfig {
  echo "
module.exports = {
  MongoURI: 'mongodb+srv://user:password@cluster0.0wmx5.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'
}" >> test.txt
}

function writeSrcFiles {
  echo '
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Bare Bones App</title>
</head>
<body>
  <div id="root"></div>
</body>
</html>' >> test.txt

  echo "
import React from 'react';
import { render } from 'react-dom';
import App from './app';

render(<App />, document.getElementById('root'));" >> test.txt

  echo "
const App = () => {
  return (
    <h1 style={{backgroundColor: 'red'}}
        onClick={() => {console.log('hi')}}
    >Just Bones</h1>
  )
}

export default App;" >> test.txt
}

function updatePackageJSON {
  #awk 'NR==3{print "insertion"}1' test.txt
  # sed -i.bak '3i\
  # insertion\
  # ' test.txt

  sed -i.bak '7i\
  \    "start": "node server",\
  \    "build": "webpack --mode=production",\
  \    "devf": "webpack serve -mode=development --open --hot",\
  \    "devb": "nodemon server",\
  ' test.txt
}

function func {
  # writeBabelRC
  # writeServerJS
  # writeWebpackConfig
  # writeKeyConfig
  # writeSrcFiles
  updatePackageJSON
  #echo "Finished writing files"
}

func
