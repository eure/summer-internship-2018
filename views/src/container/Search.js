//ここでコンポーネントを取り込んで、connect
import { connect } from 'react-redux'
import { withRouter } from 'react-router';

import {setUserData , setRepository} from '../actions/index'

import Search from '../components/Search.jsx'

function mapStateToProps(state) {
  return state
}

function mapDispatchToProps(dispatch) {
    return {

        setUserName: (name) => { 
            dispatch(setUserData(name))
        },

        setUserRepo: (repoName) => {
            dispatch(setRepository(repoName))
        }
    }
  }

export default withRouter(connect(
    mapStateToProps,mapDispatchToProps
)(Search));