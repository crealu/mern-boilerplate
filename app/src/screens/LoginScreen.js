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

const LoginScreen = ({ updateUser }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [emailError, setEmailError] = useState('');
  const [passwordError, setPasswordError] = useState('');
  const [responseMessage, setResponseMessage] = useState('');

  function login() {
    return fetch('/login', {
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
        if (data[0].user) {
          updateTheUser(data[0].user);
          console.log(data[0].user);
        }
        console.log(data);
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

  function updateTheUser(u) {
    updateUser(u);
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
      {responseMessage.includes('success')
        ? <p>Navigate to <Link to="/dashboard">your dashboard</Link></p>
        : ''
      }
    </div>
  )
}

export default LoginScreen;
