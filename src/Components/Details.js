import React, { Component } from 'react';
import NavBarDetails from './NavBarDetails.js';
import UserDetails from './UserDetails.js';

class Details extends Component {
  state = {
    user: {}
  };

  // GitHub API で指定ユーザの JSON を取得し、state に保存
  getUser = user => {
    fetch(`https://api.github.com/users/${user}`)
      .then(response => response.json())
      .then(data => {
        this.setState({
          user: data
        });
      });
  }
  
  render() {
    // props にユーザの login があれば GitHub API でユーザデータを取得
    let userLogin;
    if (this.props.location.params) {
      userLogin = this.props.location.params.user.login;
      this.getUser(userLogin);
    }

    return (
      <div className="app">
        <NavBarDetails page="Details" />
        <UserDetails user={this.state.user}/>
      </div>
    );
  }
}

export default Details;
