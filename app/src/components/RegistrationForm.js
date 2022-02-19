import { useState } from 'react';

const FormTitle = ({ title }) => {
  return (
    <h2 className="form-title">
      {title}
    </h2>
  )
}

const FormButton = () => {
  return (
    <button
      className="submit-btn"
      type="submit"
    >Submit
    </button>
  )
}

const FormField = ({ label }) => {
  return (
    <div className="form-field">
      <label for={label}>{label.toUpperCase()}</label>
      <input name={label}/>
    </div>
  )
}

const FormLink = ({ title, onClick }) => {
  return (
    <div
      className="form-link"
      onClick={onClick}
    >
      {title == 'Log in' ? 'Sign up' : 'Log in'}
    </div>
  )
}

const RegistrationForm = () => {
  const [formTitle, setFormTitle] = useState('Sign up');
  function changeTitle() {
    if (formTitle == 'Sign up') {
      setFormTitle('Log in');
    } else {
      setFormTitle('Sign up');
    }
  }
  return (
    <form className="registration-form">
      <FormTitle title={formTitle} />
      <FormField label="email" />
      <FormField label="password" />
      <FormButton />
      <FormLink title={formTitle} onClick={() => changeTitle()}/>
    </form>
  )
}

export default RegistrationForm;
