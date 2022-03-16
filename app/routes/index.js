const express = require('express');
const mongoose = require('mongoose');
const passport = require('passport');
const cookieParser = require('cookie-parser');
const bcrypt = require('bcrypt');

const User = require('../models/user');
const { ensureAuthenticated } = require('../config/auth');
const mongo = mongoose.connection;
const router = express.Router();

router.get('/', (req, res) => {
	res.sendFile('index.html', { root: './build' });
});

router.get('/register', (req, res) => {
	res.sendFile('index.html', { root: './build' });
});

router.get('/login', (req, res) => {
	res.sendFile('index.html', { root: './build' });
});

router.get('/dashboard', ensureAuthenticated, (req, res) => {
	res.set('Content-Type', 'text/plain');
  res.sendFile('index.html', { root: './build' });
});

router.post('/register', (req, res) => {
  const { email, password } = req.body;
  let errors = [];
  User.findOne({ email: email })
    .then(user => {
      if (user) {
        errors.push({
          type: 'failure',
          msg: 'An account with that email already exists'
        });
        res.send(errors);
      } else {
        const newUser = new User({ email, password });
				console.log(newUser);
        bcrypt.genSalt(10, (err, salt) => {
          bcrypt.hash(newUser.password, salt, (err, hash) => {
            if (err) throw err;
            newUser.password = hash;
            newUser.save()
              .then(user => {
                res.send([{
                  type: 'success',
                  msg: 'Registration successful! Redirecting...'
                }]);
                console.log(user);
              })
              .catch(err => console.log(err));
          })
        })
      }
    })
});

function successfulLogin() {
	res.setHeader('Access-Control-Allow-Origin', '*');
	return '/dashboard';
}

router.post('/login',
  passport.authenticate('local', { failureRedirect: '/login' }),
	function (req, res) {
		// router.use(express.json());

		res.redirect('/dashboard');
	}
);
// router.post('/login', (req, res, next) => {
//   passport.authenticate('local', {
//     successRedirect: successfulLogin(),
//     failureRedirect: '/login',
//   })(req, res, next);
// });


router.post('/logout', (req, res) => {
	req.logout();
	res.redirect('/');
});

module.exports = router;
