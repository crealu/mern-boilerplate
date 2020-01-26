# write frontend files
def write_webpack_config():
    webpackConfigFile = open('frontend/webpack.config.js', 'w+')
    webpackConfigCode = [
        'const path = require("path");',
        'const webpack = require("webpack");\n',
        'const HtmlWebPackPlugin = require("html-webpack-plugin");\n',
        'const htmlPlugin = new HtmlWebPackPlugin({',
        '\ttemplate: "./src/index.html",',
        '\tfilename: "index.html"',
        '});\n',
        'module.exports = {',
        '\tentry: "./src/index.js",\n',
        '\tmode: "development",\n',
        '\tmodule: {',
        '\t\trules: [',
        '\t\t\t{',
        '\t\t\t\ttest: /\\.(js|jsx)$/,',
        '\t\t\t\texclude: /(node_modules|bower_components)/,',
        '\t\t\t\tloader: "babel-loader",',
        "\t\t\t\toptions: { presets: ['@babel/env'] }",
        '\t\t\t},',
        '\t\t\t{',
        '\t\t\t\ttest: /\\.css$/,',
        '\t\t\t\tuse: ["style-loader", "css-loader"]',
        '\t\t\t}',
        '\t\t]',
        '\t},\n',
        '\tresolve: { extensions: ["*", ".js", ".jsx"] },\n',
        '\toutput: {',
        '\t\tpath: path.resolve(__dirname, "dist/"),',
        '\t\tpublicPath: "/dist/",',
        '\t\tfilename: "bundle.js"',
        '\t},\n',
        '\tdevServer: {',
        '\t\tcontentBase: path.join(__dirname, "public/"),',
        '\t\tport: 4200,',
        '\t\tpublicPath: "http://localhost:4200/dist/",',
        '\t\thotOnly: true',
        '\t}',
        '}'
    ]
    for wcc in webpackConfigCode:
        webpackConfigFile.write(wcc + '\n')

def write_babelrc():
    babelrcFile = open('frontend/.babelrc', 'w+')
    babelrcFile.write('{ "presets": ["@babel/env", "@babel/preset-react"] }')

def write_appjs():
    appJSFile = open('frontend/src/app.js', 'w+')
    appJSCode = [
        'import React, { Component } from "react";',
        'import "./style.css";\n',
        'class App extends Component {',
        '\tconstructor(props) {',
        '\t\tsuper(props);',
        '\t}',
        '\trender() {',
        '\t\treturn (',
        '\t\t\t<div className="App">',
        '\t\t\t\t<h1> Hello, World! </h1>',
        '\t\t\t</div>',
        '\t\t);',
        '\t}',
        '}\n',
        'export default App'
    ]
    for ajsc in appJSCode:
        appJSFile.write(ajsc + '\n')

def write_indexjs():
    indexJSFile = open('frontend/src/index.js', 'w+')
    indexJSCode = [
        'import React from "react";',
        'import ReactDOM from "react-dom";',
        'import App from "./app.js";\n',
        'ReactDOM.render(<App />, document.getElementById("root"));'
    ]
    for ijsc in indexJSCode:
        indexJSFile.write(ijsc + '\n')

def write_indexhtml():
    indexHTMLFileSrc = open('frontend/src/index.html', 'w+')
    indexHTMLFilePublic = open('frontend/public/index.html', 'w+')
    indexHTMLCode = [
        '<!DOCTYPE html>',
        '<html>',
        '<head>',
        '\t<meta charset="UTF-8">',
        '\t<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">',
        '\t<title>React Starter</title>',
        '</head>\n',
        '<body>',
        '\t<div id="root"></div>\n',
        '\t<script src="../dist/bundle.js"></script>',
        '</body>',
        '</html>'
    ]
    for ihc in indexHTMLCode:
        indexHTMLFileSrc.write(ihc + '\n')
        indexHTMLFilePublic.write(ihc + '\n')

def write_stylecss():
    styleCSSFile = open('frontend/src/style.css', 'w+')
    styleCSSCode = [
    '.App {',
    '\tmargin: 1rem;',
    '\tfont-family: Arial, Helvetica, sans-serif;',
    '\tcolor: red;',
    '}'
    ]
    for scc in styleCSSCode:
        styleCSSFile.write(scc + '\n')

def write_front_files():
    write_webpack_config()
    write_babelrc()
    write_appjs()
    write_indexjs()
    write_indexhtml()
    write_stylecss()

write_front_files()
