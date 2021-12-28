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

function func {
  #writeBabelRC
  writeServerJS
  echo "Finished writing files"
}

func
