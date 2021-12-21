import { AutoUIApp } from 'rendition'
import logo from './logo.svg';
import openApiJson from './open-api.json';

const App = () => {
	return <AutoUIApp title={process.env.REACT_APP_TITLE ?? ''} logo={logo} openApiJson={openApiJson} />;
};

export default App;