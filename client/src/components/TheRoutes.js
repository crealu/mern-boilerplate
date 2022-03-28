import { BrowserRouter, Routes, Route } from 'react-router-dom';
import LandingPage from '../screens/LandingPage';
import UserDashboard from '../screens/UserDashboard';
import RegistrationForm from '../screens/RegistrationForm';
import LoginForm from '../screens/LoginForm';
import NavBar from '../components/NavBar';

const TheRoutes = (props) => {
  return (
    <BrowserRouter>
      <NavBar />
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/register" element={<RegistrationForm />} />
        <Route path="/login" element={<LoginForm />} />
        <Route path="/dashboard" element={<UserDashboard />} />
      </Routes>
    </BrowserRouter>
  )
}

export default TheRoutes;
