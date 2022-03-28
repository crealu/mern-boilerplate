const express = require('express');
const session = require('express-session');
const mongoose = require('mongoose');
const sessionsURI = require('./config/keys').SessionsURI;
const port = process.env.PORT || 5500;
const app = express();

mongoose
  .connect(sessionsURI, {useUnifiedTopology: true, useNewUrlParser: true})
  .then(() => console.log('Connected to Database'))
  .catch(err => console.log(error));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(session({
  secret: 'Justan3asyse5h',
  resave: false,
  saveUninitialized: true,
  cookie: {
    secure: false,
    maxAge: 60 * 1000 // 60s
  }
}));

const isAuth = (req, res, next) => {
  if (req.session.isAuth) {
    next();
  } else {
    res.status(401).json('Unauthorized');
  }
}

app.use('/', require('./routes/index'));
app.use('/', require('./routes/user'));
app.use('/', require('./routes/register'));

app.listen(port, () => console.log(`Listening on ${port}`));
