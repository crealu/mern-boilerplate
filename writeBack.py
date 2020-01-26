def writeServerScript():
    serverFile = open('backend/server.js', 'w+');
    serverCode = [
        "const express = require('express');",
        'const app = express();\n',
        'const port = 4020;',
        'app.listen(port);\n',
        "app.get('/', (req, res) => {",
        "\tres.status(200).send('working');",
        "\tconsole.log('listening on ' + port);",
        '});'
    ]
    for sc in serverCode:
        serverFile.write(sc + '\n')

def writeIndexEjs():
    indexEjsFile = open('backend/views/index.ejs', 'w+')
    indexEjsCode = [
        '<!DOCTYPE html>',
        '<html>',
        '<head>',
        '\t<meta charset="utf-8">',
        '\t<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">',
        '\t<title>Boiled</title>',
        '</head>',
        '<body>\n',
        '</body>',
        '</html>'
    ]
    for iec in indexEjsCode:
        indexEjsFile.write(iec + '\n')

writeServerScript()
writeIndexEjs()
