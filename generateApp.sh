#!/bin/bash

# Produces a full stack application with React, Express/Node, MongoDB

function writeBabelRC {
echo '
{
	"presets": [
		"@babel/preset-env",
		["@babel/preset-react", {"runtime": "automatic"}]
	]
}
' >> .babelrc
}

function writeServer {
echo "
const express = require('express');
const mongoose = require('mongoose');
const passport = require('passport');
const session = require('express-session');
const cookieParser = require('cookie-parser');
const path = require('path');
const dotenv = require('dotenv').config();

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
	secret: process.env.SESSION_SECRET,
	resave: true,
	saveUninitialized: true,
	cookie: {
		httpOnly: true,
		maxAge: parseInt(process.env.SESSION_MAX_AGE)
	}
}));

app.use(passport.initialize());
app.use(passport.session());
app.use(cookieParser());

app.use('/', require('./routes/index'));

app.listen(port, () => console.log('Listening on ' + port));
" >> server.js
}

function writeWebpackConfig {
echo "
const path = require('path');
const HtmlWebPackPlugin = require('html-webpack-plugin');

module.exports = {
  mode: 'development',
  output: {
    path: path.resolve(__dirname, 'build'),
    filename: 'bundle.js'
  },
  resolve: {
    modules: [path.join(__dirname, 'src'), 'node_modules'],
    alias: {
      react: path.join(__dirname, 'node_modules', 'react')
    }
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        },
      },
      {
        test: /\.css/,
        use: [
          {
            loader: 'style-loader'
          },
          {
            loader: 'css-loader'
          }
        ]
      }
    ]
  },
  plugins: [
    new HtmlWebPackPlugin({
      template: './src/index.html'
    })
  ],
  devServer: {
    port: 9000,
    hot: true
  }
}
" >> webpack.config.js
}

function iterativeWrite {
  lines=("$@")
  for line in "${lines[@]}"; do
    echo $line >> $1
  done
}

function writeConfig {
echo "
module.exports = {
	MongoURI: 'mongodb+srv://user:password@cluster0.pw5zp.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'
}
" >> config/keys.js

echo "
module.exports = {
  ensureAuthenticated: function(req, res, next) {
    if (req.isAuthenticated()) {
      console.log('req.isAuthenticated() = true')
      return next();
    }
  }
}
" >> config/auth.js

echo "
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
" >> config/passport.js
}

function writeSrc {
echo '
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>App</title>
</head>
<body>
	<div id="root"></div>
</body>
</html>
' >> src/index.html

echo "
import React from 'react';
import { render } from 'react-dom';
import App from './app';
import './style.css';
import regeneratorRuntime from 'regenerator-runtime';

render(<App />, document.getElementById('root'));
" >> src/index.js

echo "
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { useState } from 'react';
import RegisterScreen from './screens/RegisterScreen';
import LoginScreen from './screens/LoginScreen';
import UserDashboard from './screens/UserDashboard';
import LandingPage from './screens/LandingPage';
import Navigation from './components/Navigation';

const App = () => {
	const [userAuthenticated, setUserAuthenticated] = useState(false);

	return (
		<div>
			<Router>
				<Navigation />

				<Routes>
					<Route path="/" element={<LandingPage />} />
					<Route path="register" element={<RegisterScreen />} />
					<Route path="login" element={<LoginScreen />} />
					<Route path="dashboard" element={<UserDashboard />} />
				</Routes>
			</Router>
		</div>
	)
}

export default App;
" >> src/app.js
}

function writeSrcComponents {
echo '
import { Link } from "react-router-dom";

const Navigation = () => {
  return (
    <div className="navigation">
			<Link to="/">Home</Link>
			<Link to="/register">Register</Link>
			<Link to="/login">Login</Link>
			<Link to="/dashboard">Dashboard</Link>
    </div>
  )
}

export default Navigation;
' >> src/components/Navigation.js
}

function writeSrcScreens {
echo "
const LandingPage = () => {
  return (
    <div>
      Welcome to the landing Page!
    </div>
  )
}

export default LandingPage;
" >> src/screens/LandingPage.js

echo "
import { useState } from 'react';
import { Link } from 'react-router-dom';

const FormField = ({ label, error, onChange }) => {
  function capitalizeLabel() {
    return `${label[0].toUpperCase()}${label.split(label[0])[1]}`
  }

  return (
    <div className="form-field">
      <label htmlFor={label}>{capitalizeLabel()}</label>
      <input name={label} onChange={onChange} />
      <p
        className="error-msg"
        style={{opacity: `${error == '' ? '0' : '1'}`}}
      >
        {error}.
      </p>
    </div>
  )
}

const LoginScreen = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [emailError, setEmailError] = useState('');
  const [passwordError, setPasswordError] = useState('');
  const [responseMessage, setResponseMessage] = useState('');

  async function login() {
    return await fetch('/login', {
      method: 'post',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({
        email: email,
        password: password
      }),
    })
    .then(res => { return res.json() })
    .catch(err => console.error(err))
  }

  function submitCredentials() {
    if (emailError == '' && passwordError == '') {
      login().then(data => {
        const msg = data != undefined ? data[0].msg : '';
        const type = data != undefined ? data[0].type : '';
        setResponseMessage(data[0].msg);
        console.log(data[0]);
      });
    }
  }

  function updateEmail(emailValue) {
    const error = !emailValue.includes('@')
      ? 'Please provide a valid email address'
      : '';
    setEmailError(error);
    setEmail(emailValue);
  }

  function updatePassword(passwordValue) {
    const error = passwordValue.length <= 5
      ? 'Password must be 6 character or more'
      : '';
    setPasswordError(error);
    setPassword(passwordValue);
  }

  return (
    <div className="registration-form">
      <h2 className="form-title">Log in</h2>
      <FormField
        label="email"
        error={emailError}
        onChange={(e) => updateEmail(e.target.value)}
      />
      <FormField
        label="password"
        error={passwordError}
        onChange={(e) => updatePassword(e.target.value)}
      />

      <button
        className="submit-btn"
        onClick={() => submitCredentials()}
      >
        Submit
      </button>
      <p className="have-acct">
        <span>Don't have an account? </span>
        <Link to="/register">Sign up</Link>
      </p>
      <p
        className="registration-response"
        style={{
          display: `${responseMessage == '' ? 'none' : 'block'}`,
          backgroundColor: `${
            responseMessage.includes('already')
              ? 'lightcoral'
              : 'lightgreen'
          }`
        }}
      >
        {responseMessage}
      </p>
    </div>
  )
}

export default LoginScreen;
" >> src/screens/LoginScreen.js

echo "
import { useState } from 'react';
import { Link } from 'react-router-dom';

const FormField = ({ label, error, onChange }) => {
  function capitalizeLabel() {
    return `${label[0].toUpperCase()}${label.split(label[0])[1]}`
  }

  return (
    <div className="form-field">
      <label htmlFor={label}>{capitalizeLabel()}</label>
      <input name={label} onChange={onChange} />
      <p
        className="error-msg"
        style={{opacity: `${error == '' ? '0' : '1'}`}}
      >
        {error}.
      </p>
    </div>
  )
}

const RegisterScreen = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [emailError, setEmailError] = useState('');
  const [passwordError, setPasswordError] = useState('');
  const [responseMessage, setResponseMessage] = useState('');

  async function register() {
    return await fetch('/register', {
      method: 'post',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({
        email: email,
        password: password
      }),
    })
    .then(res => { return res.json() })
    .catch(err => console.error(err))
  }

  function submitRegistration() {
    if (emailError == '' && passwordError == '') {
      register().then(data => {
        const msg = data != undefined ? data[0].msg : '';
        const type = data != undefined ? data[0].type : '';
        setResponseMessage(data[0].msg);
        console.log(data[0]);
      });
    }
  }

  function updateEmail(emailValue) {
    const error = !emailValue.includes('@')
      ? 'Please provide a valid email address'
      : '';
    setEmailError(error);
    setEmail(emailValue);
  }

  function updatePassword(passwordValue) {
    const error = passwordValue.length <= 5
      ? 'Password must be 6 character or more'
      : '';
    setPasswordError(error);
    setPassword(passwordValue);
  }

  return (
    <div className="registration-form">
      <h2 className="form-title">Sign up</h2>
      <FormField
        label="email"
        error={emailError}
        onChange={(e) => updateEmail(e.target.value)}
      />
      <FormField
        label="password"
        error={passwordError}
        onChange={(e) => updatePassword(e.target.value)}
      />

      <button
        className="submit-btn"
        onClick={() => submitRegistration()}
      >
        Submit
      </button>
      <p className="have-acct">
        <span>Have an account? </span>
        <Link to="/login">Login</Link>
      </p>
      <p
        className="registration-response"
        style={{
          display: `${responseMessage == '' ? 'none' : 'block'}`,
          backgroundColor: `${
            responseMessage.includes('already')
              ? 'lightcoral'
              : 'lightgreen'
          }`
        }}
      >
        {responseMessage}
      </p>
    </div>
  )
}

export default RegisterScreen;
" >> src/components/RegisterScreen.js

echo "
import { useState } from 'react';

const UserDashboard = ({ email }) => {

  function logout() {
    console.log('logout');
  }

  return (
    <div>
      <p>Email: {email}</p>
      <button onClick={() => logout()}>Logout</button>
    </div>
  )
}

export default UserDashboard;
" >> src/components/UserDashboard.js
}

function updatePackageJSON {
  sed -i.bak '7i\
  \    "start": "node server",\
  \    "build": "webpack --mode=production",\
  \    "devf": "webpack serve --open --hot",\
  \    "devb": "webpack --mode=production && nodemon server",\
  ' package.json

  rm package.json.bak
}

function writeRoutes {
  echo "writing routes/index.js"
}

function writeModels {
echo "
const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
  email: {
    type: 'String',
    required: true
  },
  password: {
    type: 'String',
    required: true
  }
});

module.exports = mongoose.model('User', UserSchema);
" >> models/user.js
}

function writeStyle {
  echo "/**/
  :root {
    --form-bg: linear-gradient(135deg, rgba(220, 220, 220, 1) 0%, rgba(160, 160, 160, 1) 100%);
    --btn-bg: linear-gradient(-45deg, rgba(100, 100, 210, 1) 0%, skyblue 100%);
  }

  body {
    font-family: Helvetica;
  }

  .page-title {
    text-align: center;
    margin-bottom: 40px;
  }

  .registration-form {
    position: relative;
    display: block;
    margin: 0 auto;
    width: 420px;
    height: 440px;
    padding: 40px;
    border-radius: 8px;
    background: var(--form-bg);
    box-shadow: 0px 0px 12px rgba(0, 0, 0, 0.35);
  }

  .form-title {
    font-size: 30px;
    text-align: center;
    margin-bottom: 30px;
    letter-spacing: 2px;
  }

  .form-field {
    display: grid;
    grid-template-columns: repeat(1, 1fr);
  }

  .form-field label {
    position: relative;
    padding-bottom: 10px;
  }

  .form-field input {
    font-size: 20px;
    padding: 6px;
    border: none;
    border-radius: 4px;
  }

  .error-msg {
    font-size: 14px;
    margin: 5px 0px 26px 0px;
    color: #ef3434;
  }

  .submit-btn {
    width: 100%;
    padding: 10px 16px;
    margin: 30px 0px;
    border: none;
    border-radius: 8px;
    font-size: 20px;
    background: var(--btn-bg);
    color: white;
    filter: brightness(0.9);
    cursor: pointer;
    transition: 0.25s ease;
  }

  .submit-btn:hover {
    filter: brightness(1.0);
  }

  .have-acct {
    text-align: center;
    margin: 0px;
  }

  .form-link {
    color: black;
    text-decoration: none;
  }

  .form-link:hover {
    text-decoration: underline;
  }

  .registration-response {
    position: relative;
    text-align: center;
    display: block;
    margin: 0 auto;
    padding: 10px;
    width: 420px;
    border-radius: 6px;
    top: 80px;
  }
  " >> src/style.css
}

function writeFiles {
  writeBabelRC
  writeServer
  writeWebpackConfig
  writeConfig
  writeSrc
  writeSrcComponents
  writeSrcScreens
  writeRoutes
  writeModels
  writeStyle
  updatePackageJSON
  echo "Finished writing files"
}

function generateApp {
  echo "Setting up MERN app with npm..."
  npm init -y

  dependencies=(
    react react-dom react-router-dom express express-session cookie-parser
    passport passport-local mongoose dotenv
  )

  devDependencies=(
    @babel/core @babel/preset-env @babel/preset-react
    babel-loader css-loader style-loader html-webpack-plugin
    webpack webpack-cli webpack-dev-server regenerator-runtime
  )

  function iterativeInstall {
    dependencyList=("$@")
    for d in "${dependencyList[@]}"; do
      npm install $d --save$1
    done
  }

  iterativeInstall ""     "${dependencies[@]}"
  iterativeInstall "-dev" "${devDependencies[@]}"

  directories=( build public src config models routes src/components)

  for di in "${directories[@]}"; do
    mkdir $di
  done

  srcFiles=( app.js index.js style.css index.html )
  srcScreenFiles=( LandingPage.js LoginScreen.js RegisterScreen.js UserDashboard.js )
  srcComponentFiles=( Navigation.js )
  configFiles=( keys.js passport.js auth.js )
  globalFiles=( server.js webpack.config.js .babelrc .gitignore )

  function createFiles() {
    files=("$@")
    for f in "${files[@]}"; do
      if [ "$1" == "" ] ; then
        touch "$f"
      elif [ "$1" != "$f" ] ; then
        touch "$1"/"$f"
      fi
    done
  }

  createFiles "" "${globalFiles[@]}"
  createFiles "config" "${configFiles[@]}"
  createFiles "src" "${srcFiles[@]}"
  createFiles "scr/screens" "${srcScreenFiles[@]}"
  createFiles "scr/components" "${srcComponentFiles[@]}"
  touch routes/index.js
  touch models/user.js

  echo "Finished generating configuration and source files"
  echo "Writing files..."

  writeFiles

  echo "Finished writing files"
  echo "Application setup complete"
}

generateApp $1 # main
