#!/bin/bash

# Produces a full stack application with React, Express/Node, MongoDB

function writeBabelRC {
  str='{\n\t"presets": [\n\t\t"@babel/preset-env", \n\t\t"@babel/preset-react"\n\t]\n}'
  echo $str >> .babelrc
}

function writeServerJS {
  echo "
  const express = require('express');
  const bodyParser = require('body-parser');
  const path = require('path');
  const MongoClient = require('mongodb').MongoClient;
  // const uri = require('keyconfig').MongoURI;

  const port = process.env.PORT || 9900;
  const app = express();
  // const client = new MongoClient(uri, { useNewUrlParser: true })
  " >> server.js

  echo "
  /*
  async function connectToDB() {
    await client.connect( err => {
      err ? console.log(err) : console.log('Connected to database');
    });
  }
  connectToDB();
  */

  const pathToBuild = path.join(__dirname, 'build');
  " >> server.js

  appMethods=(
    "app.use(bodyParser.urlencoded({ extended: true }));"
    "app.use(express.static(pathToBuild));"
    "app.get('/', (req, res) => {
      res.sendFile(pathToBuild, 'index.html');
    });"
    "app.listen(port, () => console.log('Listening on ' + port));"
  )

  for am in "${appMethods[@]}"; do
    echo $am >> server.js
  done
}

function writeWebpackConfig {
  echo "
  const path = require('path');
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
      port: 9900,
      hot: true
    }
  }" >> webpack.config.js
}

function writeKeyConfig {
  echo "
  module.exports = {
    MongoURI: 'mongodb+srv://user:password@cluster0.0wmx5.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'
  }" >> keyconfig.js
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
  \    "devb": "nodemon server",\
  ' package.json
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

function fullskel {
    echo "Setting up full stack (MERN) app with NPM..."

    npm init -y
    npm install express mongodb body-parser --save
    npm install nodemon --save-dev
    npm install react react-dom --save
    npm install @babel/core @babel/preset-env @babel/preset-react babel-loader css-loader style-loader --save-dev
    npm install webpack webpack-cli webpack-dev-server html-webpack-plugin --save-dev

    echo "Finished installing dependencies"
    echo "Creating configuration files..."

    touch server.js
    touch webpack.config.js
    touch keyconfig.js
    touch .babelrc
    touch .gitignore

    echo "Finished creating configuration files"
    echo "Creating frontend source files..."

    mkdir public
    mkdir build
    mkdir src
    touch src/app.js
    touch src/index.js
    touch src/style.css
    touch src/index.html


    echo "Finished creating frontend source files"
    echo "Writing files..."

    writeFiles

    echo "Finished writing files"
    echo "Application setup completed"
}

fullskel
