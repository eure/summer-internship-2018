import createReducer from '../helpers/createReducer';
import * as types from '../actions/types';

const reducer = {
	[types.SET_LOGGED_IN_STATE](state, action) {
		return action;
	}
};

export const loggedInStatus = createReducer({},reducer);


