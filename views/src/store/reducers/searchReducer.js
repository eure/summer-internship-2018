const initialState = {
    userName:'',
    userRepo: {},
    selectRepo: {}
}

export default function searchReducer(state = initialState,action){
    switch(action.type){
        case 'SET_USER':
            // stateを直接変更しないよう、Object.assignでstateを複製
            return Object.assign({},state,{
                userName: action.userName
            });

        case 'SET_REPOSITORY':
            return Object.assign({},state,{
                userRepo: action.repository
            });

        case 'SET_SELECT_REPOSITORY':
            return Object.assign({},state,{
                selectRepo: action.repository
            });

        default:
            return state;
    }
}
