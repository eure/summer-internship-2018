import React, { Component } from 'react';
import UsersList from './UsersList.js';
import TextField from '@material-ui/core/TextField';
import IconButton from '@material-ui/core/IconButton';
import Icon from '@material-ui/core/Icon';

// 位置検索テキストフィールドとユーザリスト
class Search extends Component {
  state = {
    usersList: [],
    location: ""
  };

  // GitHub API で指定位置のユーザの JSON を取得し、state に保存
  getUsers = location => {
    fetch(`https://api.github.com/search/users?q=location:${location}`)
      .then(response => response.json())
      .catch(error => console.error('Error:', error))
      .then(data => {
        this.setState({
          usersList: data.items
        });
        console.debug(this.state.usersList);
      });
  }

  // テキストフィールドの値を state に設定
  handleChange = event => {
    this.setState({ location: event.target.value });
  }

  // Search ボタンをクリックすると、GitHub API でユーザデータを取得
  handleClickSearch = () => {
    if (this.state.location !== "") {
      this.getUsers(this.state.location);
    }
  }
  
  render() {
    return (
      <div className="search-container" style={{ textAlign: "center", marginTop: 20 }}>
        {/* 位置入力 */}
        <TextField
          id="location-input"
          placeholder="Location"
          value={this.state.location}
          onChange={this.handleChange}
          margin="normal"
        />
        {/* Search ボタン */}
        <IconButton color="primary" onClick={this.handleClickSearch}>
          <Icon>search</Icon>
        </IconButton>
        {/* ユーザ表示 */}
        <UsersList users={this.state.usersList} />
      </div>
    );
  }
}

export default Search;
