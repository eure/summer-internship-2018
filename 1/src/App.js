import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import TopPage from './pages/top/TopPage';
import EventPage from './pages/event/EventPage';
import Header from './components/Header';

class App extends React.Component {
  render() {
    return (
      <div>
        <Header />
        <Router>
          <Switch>
            <Route exact path="/events" component={TopPage} />
            <Route exact path="/events/:owner/:repo/:id" component={EventPage} />
            <Route component={NotFound} />
          </Switch>
        </Router>
      </div>
    );
  }
}

const NotFound = () => (
  <div>Sorry, Not found.</div>
);

export default App;
