import { useState } from 'react';

const FormField = ({ label, onChange }) => {
  return (
    <div className="form-field">
      <label htmlFor={label}>
        {`${label[0].toUpperCase()}${label.split(label[0])[1]}`}
      </label>
      <input name={label} onChange={onChange}/>
    </div>
  )
}

const RegistrationForm = () => {
  const [emailRegister, setEmailRegister] = useState('');
  const [passwordRegister, setPasswordRegister] = useState('');
  const [formTitle, setFormTitle] = useState('Sign up');

  function register() {
    fetch('/test', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify({
        email: emailRegister,
        password: passwordRegister
      }),
    })
    .then(res => res.json())
    .then(data => console.log(data))
    .catch(err => console.error(err))
  }

	function changeTitle() {
		const newTitle = formTitle == 'Sign up' ? 'Log in' : 'Sign up';
		setFormTitle(newTitle);
	}

  return (
    <div className="registration-form">
      <h2 className="form-title">{formTitle}</h2>
      <FormField
        label="email"
        onChange={(e) => setEmailRegister(e.target.value)}
      />
      <FormField
        label="password"
        onChange={(e) => setPasswordRegister(e.target.value)}
      />
      <button
        className="submit-btn"
        onClick={() => register()}
      >
        Submit
      </button>
      <div
        className="form-link"
        onClick={() => changeTitle()}
      >
        {formTitle == 'Log in' ? 'Sign up' : 'Log in'}
      </div>
    </div>
  )
}

export default RegistrationForm;
