const FormTitle = () => {
  return (
    <h2 className="form-title">
      Sign Up
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

const RegistrationForm = () => {
  return (
    <form className="registration-form">
      <FormTitle />
      <FormField label="email"/>
      <FormField label="password"/>
      <FormButton />
    </form>
  )
}

export default RegistrationForm;
