import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import Grid from '@material-ui/core/Grid';
import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import CardContent from '@material-ui/core/CardContent';
import Avatar from '@material-ui/core/Avatar';
import Typography from '@material-ui/core/Typography';

// それぞれのユーザを Card で表示
class UserItem extends Component {  
  render() {
    const user = this.props.userItem;

    return (
      <Grid item xs={6} sm={4}>
        {/* ユーザの Card をクリックするとそのユーザの details ページへ */}
        <Link
          to={{
            pathname: "/details",
            params: { user }
          }}
          style={{textDecoration: "none"}}>
          <Card>
            <CardContent>
              <Grid container wrap="nowrap" spacing={16}>
                {/* ユーザのアバター */}
                <Grid item>
                  <Avatar src={user.avatar_url}></Avatar>
                </Grid>
                <Grid item xs>
                  {/* ユーザのアカウント */}
                  <Typography variant="subheading" style={{ textAlign: "left" }}>
                    Account: {user.login}
                  </Typography>
                  {/* ユーザの ID 番号 */}
                  <Typography variant="body1" style={{ textAlign: "left" }}>
                    ID: {user.id}
                  </Typography>
                </Grid>
              </Grid>
            </CardContent>
          </Card>
        </Link>
      </Grid>
    );
  }
}

export default UserItem;