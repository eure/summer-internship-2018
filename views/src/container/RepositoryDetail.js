import { connect } from 'react-redux'
import { withRouter } from 'react-router';

import RepositoryDetail from '../components/RepositoryDetail.jsx'

function mapStateToProps(state) {
    return {
        repo: state.searchReducer.selectRepo,
    }
}

export default withRouter(connect(
    mapStateToProps
)(RepositoryDetail));