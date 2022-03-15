import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { useState } from 'react';
import RegisterScreen from './screens/RegisterScreen';
import LoginScreen from './screens/LoginScreen';
import UserDashboard from './screens/UserDashboard';
import LandingPage from './screens/LandingPage';
import Navigation from './components/Navigation';

const App = () => {
	const [userAuthenticated, setUserAuthenticated] = useState(false);

	return (
		<div>
			<Router>
				<Navigation />

				<Routes>
					<Route path="/" element={<LandingPage />} />
					<Route path="register" element={<RegisterScreen />} />
					<Route path="login" element={<LoginScreen />} />
					<Route path="dashboard" element={<UserDashboard />} />
				</Routes>
			</Router>
		</div>
	)
}

export default App;
