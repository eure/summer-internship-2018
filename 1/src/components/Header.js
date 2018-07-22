import React from 'react';
import styled from 'react-emotion';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';

const Header = () => (
  <HeaderWrapper>
    <AppBar position="static" color="primary">
      <Toolbar>
        <Typography variant="title" color="inherit">
          Hello
        </Typography>
      </Toolbar>
    </AppBar>
  </HeaderWrapper>
);

const HeaderWrapper = styled('div')`
  margin-bottom: 20px;
`;

export default Header;
