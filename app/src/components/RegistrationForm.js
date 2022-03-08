import { useState, useReducer } from 'react';

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

const FormButton = ({ submit }) => {
  return (
    <button
      className="submit-btn"
      onClick={submit}
    >
      Submit
    </button>
  )
}

const initialFormState = {
  title: 'Sign up',
  linkText: 'Log in',
  linkUrl: '/login',
  action: '/register',
  question: 'Have an account? '
};

function reducer(state, action) {
  switch (action.type) {
    case 'Log in':
      return {
        title: 'Log in',
        linkText: 'Sign up',
        action: '/login',
        question: "Don't have an account? "
      }
    case 'Sign up':
      return {
        title: 'Sign up',
        linkText: 'Log in',
        action: '/register',
        question: "Have an account? "
      }
    default:
      throw new Error();
  }
}

const RegistrationForm = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [emailError, setEmailError] = useState('');
  const [passwordError, setPasswordError] = useState('');
  const [responseMessage, setResponseMessage] = useState('');
  const [formData, dispatch] = useReducer(reducer, initialFormState);

  async function register() {
    return await fetch(formData.action, {
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
        if (type == 'failure') {
          dispatch({type: 'Log in'});
        }
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
      <h2 className="form-title">{formData.title}</h2>
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
      <FormButton submit={() => submitRegistration()}/>
      <p className="have-acct">
        <span>{formData.question}</span>
        <a
          className="form-link"
          onClick={() => dispatch({type: formData.linkText})}
        >
          {formData.linkText}
        </a>
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

export default RegistrationForm;
