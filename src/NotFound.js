import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import Paper from '@material-ui/core/Paper';
import Typography from '@material-ui/core/Typography';
import { Link } from 'react-router-dom';

const styles = theme => ({
  root: {
    ...theme.mixins.gutters(),
    paddingTop: theme.spacing.unit * 2,
    paddingBottom: theme.spacing.unit * 2,
  },
});

function PaperSheet(props) {
  const { classes } = props;

  return (
    <div style={{minWidth: 300}}>
      <Paper className={classes.root} elevation={1}>
        <Typography variant="headline" component="h3">
          404
        </Typography>
        <Typography component="p">
          not found
        </Typography>
        <Link to='/'>
          <Typography component="p">
            ホームへのリンク
          </Typography>
        </Link> 
      </Paper>
    </div>
  );
}

PaperSheet.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(PaperSheet);
