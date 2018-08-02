import React, { Component } from 'react';
import Avatar from '@material-ui/core/Avatar';
import Grid from '@material-ui/core/Grid';
import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import Typography from '@material-ui/core/Typography';

class UserDetails extends Component { 
  render() {
    return (
      <Card style={{ padding: 20, margin: 20 }}>
        <CardContent>
          <Grid container spacing={24} style={{ padding: 20 }}>
            <Grid item xs={12} sm={5}>
              {/* ユーザのアバター */}
              <Avatar
                alt={this.props.user.name}
                src={this.props.user.avatar_url}
                style={{ width: 200, height: 200 }}>
              </Avatar>
            </Grid>
            <Grid item xs={12} sm={7}
              style={{
                textAlign: "left",
                paddingTop: 80,
                paddingBottom: 80
              }}>
              <Grid item>
                {/* ユーザの名前 */}
                <Typography variant="display2">
                  {this.props.user.name}
                </Typography>
              </Grid>
              <Grid item>
                {/* ユーザの GitHub ページへのリンク */}
                <Typography variant="title">
                  <a href={this.props.user.html_url} target="_blank"
                    style={{ color: "#f50057" }}>
                    {this.props.user.login}
                  </a>
                </Typography>
              </Grid>
            </Grid>
          </Grid>
          <Grid container spacing={24} style={{ padding: 20 }}>
            <Grid item xs={6} sm={3}>
              {/* ユーザの位置 */}
              <Grid item>
                <Typography variant="subheading" color="inherit">
                  Location
                </Typography>
              </Grid>
              <Grid item>
                <Typography variant="body2" color="secondary">
                  {this.props.user.location}
                </Typography>
              </Grid>
            </Grid>
            <Grid item xs={6} sm={3}>
              {/* ユーザのリポジトリ数 */}
              <Grid item>
                <Typography variant="subheading" color="inherit">
                  Repositories
                </Typography>
              </Grid>
              <Grid item>
                <Typography variant="body2" color="secondary">
                  {this.props.user.public_repos}
                </Typography>
              </Grid>
            </Grid>
            <Grid item xs={6} sm={3}>
              {/* ユーザのフォロワー数 */}
              <Grid item>
                <Typography variant="subheading" color="inherit">
                  Followers
                </Typography>
              </Grid>
              <Grid item>
                <Typography variant="body2" color="secondary">
                  {this.props.user.followers}
                </Typography>
              </Grid>
            </Grid>
            <Grid item xs={6} sm={3}>
              {/* ユーザのフォロー数 */}
              <Grid item>
                <Typography variant="subheading" color="inherit">
                  Following
                </Typography>
              </Grid>
              <Grid item>
                <Typography variant="body2" color="secondary">
                  {this.props.user.following}
                </Typography>
              </Grid>
            </Grid>
          </Grid>
        </CardContent>
      </Card>
    );
  }
}

export default UserDetails;