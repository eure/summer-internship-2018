import React, { Component } from 'react';
import { Provider } from 'react-redux';
import store from './redux/store';
import { createReduxBoundAddListener } from 'react-navigation-redux-helpers';
import AppWithNavigationState from './navigators/AppNavigator';

console.disableYellowBox = true;

export default class App extends Component {
	render() {
		return (
			<Provider store = {store}>
			  <AppWithNavigationState listener = {createReduxBoundAddListener('root')} />
			</Provider>
			);
	} 
}




