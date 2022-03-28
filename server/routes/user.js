const express = require('express');
const bcrypt = require('bcrypt');
const mongoose = require('mongoose');
const User = require('../models/user');
const router = express.Router();

const atlas = mongoose.connection;

router.post('/api/login', (req, res) => {
  const { username, password } = req.body;
  User.findOne({ username: username })
    .then(user => {
      if (!user) {
        res.status(400).json("Invalid username");
      }

      bcrypt.compare(password, user.password, (err, match) => {
        if (err) throw err;
        if (match) {
          req.session.isAuth = true;
          atlas.db.collection('sessions').insertOne(req.session);
          res.status(200).json({
            id: user.id,
            username: username,
            sessionId: 'a session id',
            message: 'Login successful, redirecting to dashboard..'
          })
        } else {
          res.status(400).json("Incorrect password");
        }
      });
    })
    .catch(err => console.log(err));
});

router.post('/api/logout', (req, res) => {
  req.session.destroy();
  res.redirect('/');
});

module.exports = router;
