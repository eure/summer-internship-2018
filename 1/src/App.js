import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import Home from "./Home";
import './App.css';

class App extends React.Component {
  render() {
    return (
      <Router>
        <Switch>
          <Route exact path="/" component={Home} />
          <Route exact path="/about" component={About} />
          <Route exact path="/topics" component={Topics} />
          <Route component={NotFound} />
        </Switch>
      </Router>
    );
  }
}

const About = () => (
  <div>About</div>
);

const Topics = () => (
  <div>Topics</div>
);

const NotFound = () => (
  <div>NotFound</div>
);

export default App;