import { useState } from 'react';
import axios from 'axios';

const RegistrationForm = () => {
  const [email, setEmail] = useState('');
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  async function handleRegister(e) {
    e.preventDefault();
    const res = await axios.post('/api/register', {
      username, email, password
    });
    console.log(res.data);
  }

  return (
    <form onSubmit={handleRegister}>
      <h3 className="form-title">Register</h3>
      <input
        type="text"
        placeholder="username"
        onChange={(e) => setUsername(e.target.value)}
      />
      <input
        type="text"
        placeholder="email"
        onChange={(e) => setEmail(e.target.value)}
      />
      <input
        type="password"
        placeholder="password"
        onChange={(e) => setPassword(e.target.value)}
      />
      <button type="submit" className="submit-btn">
        Register
      </button>
    </form>
  )
}

export default RegistrationForm;
