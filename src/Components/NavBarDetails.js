import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import IconButton from '@material-ui/core/IconButton';
import Icon from '@material-ui/core/Icon';
import Typography from '@material-ui/core/Typography';

// Details ページのトップバー
// Home ページへ戻るボタンを設置
class NavBarDetails extends Component {
  render() {
    return (
      <div>
        <AppBar position="static" color="secondary">
          <Toolbar>
            {/* Home ページへ戻るボタン */}
            <IconButton aria-label="Back">
              <Link to="/" style={{ color: "white" }}><Icon>arrow_back</Icon></Link>
            </IconButton>
            {/* トップバータイトル */}
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