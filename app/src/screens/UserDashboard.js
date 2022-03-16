import { useState } from 'react';

const UserDashboard = ({ email }) => {
  function logout() {
    fetch('/logout', {
      method: 'post',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({
        email: email
      })
    })
    .then(res => { return res.json()})
    .catch(err => console.error(err));
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
