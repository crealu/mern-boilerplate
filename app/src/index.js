import React from 'react';
import { render } from 'react-dom';
import App from './app';
import './style.css';

window.React = React;

render(<App />, document.getElementById('root'));
