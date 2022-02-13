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
        <FormField label="email"/>
        <FormField label="password"/>
        <button type="submit">Register</button>
      </form>
  )
}

export default RegistrationForm;
