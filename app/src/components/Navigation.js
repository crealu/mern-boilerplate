import { Link } from 'react-router-dom';

const Navigation = () => {
  return (
    <div className="navigation">
			<Link to="/">Home</Link>
			<Link to="/register">Register</Link>
			<Link to="/login">Login</Link>
			<Link to="/dashboard">Dashboard</Link>
    </div>
  )
}

export default Navigation;
