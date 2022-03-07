const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const MongoClient = require('mongodb').MongoClient;
const port = process.env.PORT || 9100;
const app = express();

// const uri = require('keyconfig').MongoURI;
// const client = new MongoClient(uri, { useNewUrlParser: true })

// async function connectToDB() {
// 	await client.connect( err => {
// 		err ? console.log(err) : console.log('Connected to database');
// 	});
// }
// connectToDB();
const pathToBuild = path.join(__dirname, 'build');
app.use(express.static(pathToBuild));

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.get('/', (req, res) => {
	res.sendFile(pathToBuild, 'index.html');
});

app.post('/test', (req, res) => {
	res.send('registration successful');
	console.log(req.body);
});

app.listen(port, () => console.log('Listening on ' + port));
