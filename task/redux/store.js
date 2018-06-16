import { compose, createStore, applyMiddleware } from 'redux';
import { createLogger } from 'redux-logger';
import thunkMiddleware from 'redux-thunk';
import reducer from './reducers';
import { createReactNavigationReduxMiddleware } from 'react-navigation-redux-helpers';

const loggerMiddleware = createLogger({ predicate: (getState, action) => __DEV__ });
// reduxとreact-navigationの橋渡し
const navigationMiddleware = createReactNavigationReduxMiddleware(
  "root",
  (state) => state.nav,
);

function configureStore(initialState) {
	const enhancer = compose(
		applyMiddleware(
			//使用するMiddlewareを書く
			thunkMiddleware,
			navigationMiddleware,
			loggerMiddleware,
			),
		// thirdPartyLibraryを使用時はここに書く
		);
	return createStore(reducer, initialState, enhancer);
}

export default configureStore({});


  

