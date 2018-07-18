//ユーザー名を格納するaction
export const setUserData = (userName)=>{
    return {
        type: 'SET_USER',
        userName
    }
}

//getしたリポジトリ一覧を格納するaction
export const setRepository = (repository)=>{
    return {
        type: 'SET_REPOSITORY',
        repository
    }
}

//ユーザーが選択したリポジトリを格納するaction
export const setSelectRepository = (repository)=>{
    return {
        type: 'SET_SELECT_REPOSITORY',
        repository
    }
}