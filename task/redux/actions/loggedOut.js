// 気にしないでください
import * as types from './types';

export function setLoggedInState(loggedInState) {
  return {
  	type: types.SET_LOGGED_IN_STATE,
  	loggedInState,
  }
  dispatch(setLoggedInState(true));
}
