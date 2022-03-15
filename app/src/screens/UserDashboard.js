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
