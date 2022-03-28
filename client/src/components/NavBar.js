import { BrowserRouter, Link } from 'react-router-dom';

const NavBar = () => {
  return (
    <div className="page-links">
      <Link to="/">Home</Link>
      <Link to="/register">Register</Link>
      <Link to="/login">Login</Link>
      <Link to="/dashboard">Dashboard</Link>
    </div>
  )
}

export default NavBar;
