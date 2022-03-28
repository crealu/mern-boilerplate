import { useState, useContext } from 'react';
// import { Switch, Redirect } from 'react-router-dom';
import { UserContext } from '../context/context';
import axios from 'axios';

const LoginForm = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [loggedIn, setLoggedIn] = useState(false);
  const {state, dispatch} = useContext(UserContext);

  async function handleLogin(e) {
    e.preventDefault();
    const res = await axios.post('/api/login', { username, password });
    if (res.status == 200) {
      dispatch({
        type: 'set user',
        payload: res.data.username
      });
      setLoggedIn(true);
    }

    console.log(res.data);
    sessionStorage.setItem('user', res.data.username);
  }

  return (
    <div>
      {loggedIn ? window.location = '/dashboard'
       : (
         <form onSubmit={handleLogin}>
           <h3 className="form-title">Login</h3>
           <input
             type="text"
             placeholder="username"
             onChange={(e) => setUsername(e.target.value)}
           />
           <input
             type="password"
             placeholder="password"
             onChange={(e) => setPassword(e.target.value)}
           />
           <button type="submit" className="submit-btn">
             Login
           </button>
         </form>
       )
      }
    </div>
  )
}

export default LoginForm;
