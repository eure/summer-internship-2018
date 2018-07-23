import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Typography from '@material-ui/core/Typography';
import NotFound from './NotFound';

const styles = {
  card: {
    minWidth: 300,
  },
  media: {
    height: 0,
    paddingTop: '56.25%', // 16:9
  },
};

function Detail(props) {
  const { classes } = props;
  const repositoryData = props.location.repositoryData;
  
  if (repositoryData === undefined) {
      return <NotFound/>
  }
  
  return (
    <div>
      <Card className={classes.card}>
        <CardMedia
          className={classes.media}
          image={props.location.repositoryData.owner.avatar_url}
          title={"Github Image"}
        />
        <CardContent>
          <Typography gutterBottom variant="headline" component="h2">
           {repositoryData.name}
          </Typography>
          <Typography component="p">
            フォーク数: {repositoryData.forks_count}
          </Typography>
          <Typography component="p">
            スター数: {repositoryData.stargazers_count}
          </Typography>
        </CardContent>
      </Card>
    </div>
  );
}

Detail.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(Detail);
