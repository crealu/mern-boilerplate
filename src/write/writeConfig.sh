#!/bin/bash

function writeBabelRC {
  str='{\n\t"presets": [\n\t\t"@babel/preset-env", \n\t\t"@babel/preset-react"\n\t]\n}'
  echo $str >> .babelrc
}

function writeKeyConfig {
  kConfig=(
    "module.exports = {"
    "\tMongoURI: 'mongodb+srv://user:password@cluster0.0wmx5.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'"
    "}"
  )
  for kc in "${kConfig[@]}"; do
    echo $kc >> key.js
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

function writeConfigFiles {
  writeBabelRC
  writeKeyConfig
}
