//actionのタイプによってstateを変化させるReducerを作るcreateReducerを作成(Reducerを用意する度にswitch文を何度も使いたくない)
export default function createReducer(initialState, handlers) {
	return function reducer(state = initialState, action) {
		if (handlers.hasOwnProperty(action.type)) {
			return handlers[action.type](state, action);
		}
		return state;
	}
}

