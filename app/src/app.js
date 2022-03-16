import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { useState } from 'react';
import RegisterScreen from './screens/RegisterScreen';
import LoginScreen from './screens/LoginScreen';
import UserDashboard from './screens/UserDashboard';
import LandingPage from './screens/LandingPage';
import Navbar from './components/Navbar';

const App = () => {
	const [username, setUsername] = useState('');

	function updateUsername(theUsername) {
		setUsername(theUsername);
		console.log('user updated');
	}

	return (
		<div>
			<Router>
				<Navbar />
				<Routes>
					<Route
						path="/"
						element={<LandingPage />}
					/>
					<Route
						path="register"
						element={<RegisterScreen />}
					/>
					<Route
						path="login"
						element={<LoginScreen updateUser={updateUsername} />}
					/>
					<Route
						path="dashboard"
						element={<UserDashboard email={username} />}
					/>
				</Routes>
			</Router>
		</div>
	)
}

export default App;
