const express = require('express');
const bcrypt = require('bcrypt');
const User = require('../models/user');
const router = express.Router();

function hashAndSave(user, res) {
  bcrypt.genSalt(10, (err, salt) => {
    bcrypt.hash(user.password, salt, (err, hash) => {
      if (err) throw err;
      user.password = hash;
      user.save()
        .then(() => { res.status(200).json("Registration successful") })
        .catch(err => console.log(err));
    })
  })
}

router.post('/api/register', (req, res) => {
  const { username, email, password } = req.body;
  console.log(req.body);

  User.findOne({ email: email }).then(user => {
    if (user) {
      res.status(400).json("An account with that email already exists")
    } else {
      const newUser = new User({ username, email, password });
      hashAndSave(newUser, res);
    }
  });
});

module.exports = router;
