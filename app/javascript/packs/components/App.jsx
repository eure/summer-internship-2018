import React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Link,
  Switch,
} from 'react-router-dom';

// githubのトレンドをリスト形式でレンダリングするコンポーネント
import ListPage from './ListPage';
// リポジトリの詳細をレンダリングするコンポーネント
import ShowPage from './ShowPage';

const App = () => (
  <Router>
    <Switch>
      <Route exact path="/trends/index" component={ListPage}></Route>
      <Route exact path="/trends/repository" component={ShowPage}></Route>
    </Switch>
  </Router>
);
export default App;