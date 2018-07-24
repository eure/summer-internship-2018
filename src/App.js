import React, { Component } from 'react';
import './App.css';
import Header from './Header';
import Main from './Main'
import axios from 'axios';

class App extends Component {
  state = {
    repolist: [],
    userName: ""
  };

  handleSearch = event => {
    axios.get(`https://api.github.com/users/${this.state.userName}/starred`)
      .then(response => {
        console.log('status:', response.status);
        console.dir(response.data);
        this.setState({
          repolist: response.data
        })
      })
  }

handleChange = event => {
  this.setState({
    userName:event.target.value,
  });
};

  render() {
    return (
      <div className="App">
        <Header/>
        <Main
          userName={this.state.userName}
          handleChange={this.handleChange}
          handleSearch={this.handleSearch}
          repolist={this.state.repolist}
        />
      </div>
    );
  }
}

export default App;
