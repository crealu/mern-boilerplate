import { useState } from 'react';
import { Link } from 'react-router-dom';

const UserDashboard = ({ email }) => {

  return (
    <div>
      <p>Email: {email}</p>
      <Link to="/logout">Logout</Link>
    </div>
  )
}

export default UserDashboard;
