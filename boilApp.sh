#!/bin/bash

# Produces a full stack application with React, Express/Node, MongoDB

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

    echo "finishec initializing files and directories"

    node -v
    npm -v
}
