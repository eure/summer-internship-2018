import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { StackNavigator, addNavigationHelpers } from 'react-navigation';
import LogIn from '../LogIn';
import First from '../First';
import Detail from '../Detail';

export const AppNavigator = StackNavigator({
  LogIn: LogIn,
  First: First,
  Detail: Detail,
});

// stateを各コンポーネントに渡すための枠組み
const AppWithNavigationState = ({ dispatch, nav, listener }) => (
<AppNavigator navigation = {addNavigationHelpers({
  dispatch,
  state: nav,
  addListener: listener })} />
);

AppWithNavigationState.propTypes = {
  dispatch: PropTypes.func.isRequired,
  nav: PropTypes.object.isRequired,
};

const mapStateToProps = (state) => ({
  nav: state.nav
});

export default connect(mapStateToProps)(AppWithNavigationState);
