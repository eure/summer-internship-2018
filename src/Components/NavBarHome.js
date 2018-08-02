import React, { Component } from 'react';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';

// Home ページのトップバー
class NavBarDetails extends Component {
  render() {
    return (
      <div>
        <AppBar position="static" color="secondary">
          <Toolbar>
            <Typography variant="title" color="inherit">
              GitHub Location Search - {this.props.page}
            </Typography>
          </Toolbar>
        </AppBar>
      </div>
    );
  }
}

export default NavBarDetails;