import os

os.system('mkdir frontend')
os.chdir('frontend')

cmds = [
    'mkdir public',
    'mkdir src',
    'abc > public/index.html',
    'abc > src/index.js',
    'abc > src/app.js',
    'abc > src/style.css',
    'abc > src/index.html',
    'abc > webpack.config.js',
    'abc > .babelrc',
    'abc > .gitignore',
    'npm init -y'
]

for c in cmds:
    os.system(c)

os.system('npm install --save react react-dom')

npm_install = 'npm install --save-dev'

packages = [
    '@babel/cli',
    '@babel/core',
    '@babel/preset-env',
    '@babel/preset-react',
    'babel-loader',
    'css-loader',
    'style-loader',
    'html-webpack-plugin',
    'webpack',
    'webpack-cli',
    'webpack-dev-server',
]

for p in packages:
    npm_install += ' ' + p

os.system(npm_install)
