import React, { Component, Fragment } from 'react';
import Search from './Search.js';
import NavBarHome from './NavBarHome.js';

// Home page
class Home extends Component {
  render() {
    return (
      <Fragment>
        <NavBarHome page="Home" />
        <Search />
      </Fragment>
    );
  }
}

export default Home;