import { useContext } from 'react';
import { UserContext } from '../context/context';
import axios from 'axios';

const UserDashboard = () => {
  const {state, dispatch} = useContext(UserContext)

  async function handleLogout() {
    const res = await axios.post('api/logout');
    if (res.status == 200) {
      sessionStorage.removeItem('user');
      window.location = '/';
    }
  }

  return (
    <div>
      <h2>Dashboard</h2>
      <p>{state.user}</p>
      <button onClick={handleLogout}>Logout</button>
    </div>
  )
}

export default UserDashboard;
