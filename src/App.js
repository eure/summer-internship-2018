import React, { Component } from 'react';
import Home from './Components/Home.js';
import Details from './Components/Details.js';
import { BrowserRouter as Router, Route } from 'react-router-dom';

class App extends Component {
  render() {
    return (
      <Router>
        <div className="app">
          <Route exact path="/" component={Home} />
          <Route path="/details" component={Details} />
        </div>
      </Router>
    );
  }
}

export default App;
