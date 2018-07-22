import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import TopPage from "./TopPage";
import EventPage from "./EventPage";

class App extends React.Component {
  render() {
    return (
      <Router>
        <Switch>
          <Route exact path="/events" component={TopPage} />
          <Route exact path="/events/:id" component={EventPage} />
          <Route component={NotFound} />
        </Switch>
      </Router>
    );
  }
}

const NotFound = () => (
  <div>Sorry, Not found.</div>
);

export default App;
