#!/bin/bash

# Produces a full stack application with React, Express/Node, MongoDB

function writeBabelRC {
  str='{\n\t"presets": [\n\t\t"@babel/preset-env", \n\t\t"@babel/preset-react"\n\t]\n}'
  echo $str >> .babel.rc
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
      echo "${mainstr2};" >> server.js
    else
      echo "${mainstr};" >> server.js
    fi

    n=$((n + 1))
  done

  echo "\nasync function connectToDB() {\n\tawait client.connect( err => {
    err ? console.log(err) : console.log('Connected to database');
  });\n}" >> server.js
  echo "connectToDB();" >> server.js
  echo "\nconst pathToBuild = path.join(__dirname, 'build');\n" >> server.js

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
    }" >> webpack.config.js
}

function writeKeyConfig {
  echo "module.exports = {
    MongoURI: 'mongodb+srv://user:password@cluster0.0wmx5.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'
  }" >> keyconfig.js
}

function writeSrcFiles {
  echo '<!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <title>Bare Bones App</title>
    </head>
    <body>
      <div id="root"></div>
    </body>
    </html>' >> src/index.html

  echo "import React from 'react';
    import { render } from 'react-dom';
    import App from './app';

    render(<App />, document.getElementById('root'));" >> src/index.js

  echo "const App = () => {
      return (
        <h1 style={{backgroundColor: 'red'}}
            onClick={() => {console.log('hi')}}
        >Just Bones</h1>
      )
    }

    export default App;" >> src/app.js
}

function writeFiles {
  writeBabelRC
  writeServerJS
  writeWebpackConfig
  writeKeyConfig
  writeSrcFiles
}

function fullskel {
    echo "creating full stack app with react and node..."

    npm init -y
    npm install express mongodb body-parser --save
    npm install nodemon --save-dev
    npm install react react-dom --save
    npm install @babel/core @babel/preset-env @babel/preset-react babel-loader css-loader style-loader --save-dev
    npm install webpack webpack-cli webpack-dev-server html-webpack-plugin --save-dev

    touch server.js
    touch webpack.config.js
    touch keyconfig.js
    touch .babelrc
    touch .gitignore

    mkdir src
    touch src/app.js
    touch src/index.js
    touch src/style.css
    touch src/index.html

    mkdir build

    writeFiles

    echo "Finished creating file structure and installing dependencies"
}

fullskel
