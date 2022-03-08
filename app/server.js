const express = require('express');
const mongoose = require('mongoose');
const passport = require('passport');
const session = require('express-session');
const cookieParser = require('cookie-parser');
const path = require('path');

const { initPassport } = require('./config/passport');
const uri = require('./config/keys').MongoURI;
const port = process.env.PORT || 9100;
const app = express();
const pathToBuild = path.join(__dirname, './build');

initPassport(passport);

mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true })
	.then(() => console.log('Connected to database'))
	.catch(err => console.log(err))

app.use(express.static(pathToBuild));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

app.use(session({
	secret: 'keyboard cat',
	resave: true,
	saveUninitialized: true,
	maxAge: 360000
}));

app.use(passport.initialize());
app.use(passport.session());

app.use('/', require('./routes/index'));
app.use(cookieParser());

app.listen(port, () => console.log(`Listening on ${port}`));
