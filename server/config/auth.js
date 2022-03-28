const bcrypt = require('bcrypt');
const monogoose = require('mongoose');
const User = require('../models/user');

module.exports = {
  authenticate: function(username, password) {
    User.findOne({ username: username })
      .then(user => {
        if (!user) {
          return false;
        }

        bcrypt.compare(password, user.password, (err, match) => {
          if (err) throw err;
          if (match) {
            return user;
          } else {
            return false;
          }
        });
      })
      .catch(err => console.log(err));
  }
}
