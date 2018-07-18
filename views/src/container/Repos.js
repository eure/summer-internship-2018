import { connect } from 'react-redux'
import { withRouter } from 'react-router';

import Repos from '../components/Repos.jsx'

import { setSelectRepository } from '../actions/index'

function mapStateToProps(state) {
    return {
        repos: state.searchReducer.userRepo, //リポジトリ一覧
        userName: state.searchReducer.userName //ユーザー名
    }
}

function mapDispatchToProps(dispatch) {
    return {    
        setSelectRepository: (repository) => { 
            dispatch(setSelectRepository(repository))
        }
    }
}

export default withRouter(connect(
    mapStateToProps,mapDispatchToProps
)(Repos));