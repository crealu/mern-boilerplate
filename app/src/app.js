import RegistrationForm from './components/RegistrationForm';

const PageTitle = () => {
	return (
		<h1 className="page-title">
			Awesome frontend here! If you see this, you're doing great.
		</h1>
	)
}

const App = () => {
	return (
		<div>
			<PageTitle />
			<RegistrationForm />
		</div>
	)
}

export default App;
