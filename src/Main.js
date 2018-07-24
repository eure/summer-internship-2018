import React, { Component } from 'react';
import './App.css';
import Textfield from '@material-ui/core/TextField'
import Button from '@material-ui/core/Button'
import List from '@material-ui/core/List'
import ListItem from '@material-ui/core/ListItem'
import ListItemText from '@material-ui/core/ListItemText'
import Avatar from '@material-ui/core/Avatar'
import Grid from '@material-ui/core/Grid';
import { Route, Link } from 'react-router-dom'
import Detail from './Detail';

const Main = props => {
    return (
      <main>
        <Grid container justify='center'>
          <Grid item>
            <Route
              exact
              path='/'
              render={() =>
                <div>
                  <Textfield
                    label="Name"
                    value={props.username}
                    onChange={props.handleChange}
                  />
                  <Button variant="contained" color="primary" onClick={props.handleSearch}>
                    Serch
                  </Button>
                  <List>
                    {props.repolist.map((value, index) => (
                      <Link key={index} to={{pathname: '/detail', repositoryData: value}}>
                        <ListItem dense button>
                          <Avatar alt="Remy Sharp" src={value.owner.avatar_url} />
                          <ListItemText primary={value.name} />
                        </ListItem>
                      </Link>
                    ))}
                  </List>
                </div>
                  }
              />
              <Route path='/detail' component={Detail}/>
            </Grid>
          </Grid>
      </main>
    );
  }

export default Main;
