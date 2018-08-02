import React, { Component } from 'react';
import UserItem from './UserItem.js';
import Grid from '@material-ui/core/Grid';

// ユーザリスト
class UsersList extends Component {
  render() {
    const users = this.props.users;
    
    // それぞれのユーザを表示
    let userCards;
    if (users.length !== 0) {
      userCards = users.map(userItem =>
        <UserItem key={userItem.id} userItem={userItem} />
      );
    }

    // グリッドでユーザをリスト
    return (
      <Grid container spacing={24} style={{ padding: 10 }}>
        {userCards}
      </Grid>
    );
  };
}

export default UsersList;