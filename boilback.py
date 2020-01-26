import os

os.system('mkdir backend')
os.chdir('backend')

cmds = [
    'mkdir views',
    'mkdir src',
    'abc > server.js',
    'abc > views/index.ejs',
    'abc > src/style.css',
    'npm init -y'
]

for c in cmds:
    os.system(c)

os.system('npm install --save-dev nodemon')

npm_install = 'npm install --save'

packages = [
    'express',
    'ejs',
    'body-parser',
    'mongodb'
]

for p in packages:
    npm_install += ' ' + p

os.system(npm_install)
