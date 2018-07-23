import React from 'react';
import styled from 'react-emotion';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import IconButton from '@material-ui/core/IconButton';
import MenuIcon from '@material-ui/icons/Menu';

const Header = () => (
  <HeaderWrapper>
    <AppBar position="static" color="primary" children={<input />}>
      <Toolbar>
        <IconButton color="inherit" aria-label="Menu">
          <MenuIcon />
        </IconButton>

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
