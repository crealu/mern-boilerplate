const LocalStrategy = require('passport-local').Strategy;
const bcrypt = require('bcrypt');
const mongoose = require('mongoose');
const User = require('../models/user');

module.exports = {
  initPassport: function(passport) {
    passport.use(
      new LocalStrategy({ usernameField: 'email' }, (email, password, done) => {
        User.findOne({ email: email })
          .then(user => {
            if (!user) {
              return done(null, false, { message: 'Invalid email' });
            }

            bcrypt.compare(password, user.password, (err, isMatch) => {
              if (err) throw err;
              if (isMatch) {
                return done(null, user);
              } else {
                return done(null, false, { message: 'Incorrect password' });
              }
            })
          })
          .catch(err => console.log(err));
      })
    );


    passport.serializeUser((user, done) => {
      done(null, user.id);
    });

    passport.deserializeUser((id, done) => {
      User.findById(id, (err, user) => {
        done(err, user);
      })
    });
  }
}
