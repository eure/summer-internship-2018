import React from 'react';
import {
  Card,
  CardHeader,
  CardContent,
  Grid,
  withStyles
} from '@material-ui/core';

const styles = theme => ({
  container: {
    width: '100%',
    height: '100%',
    display: 'flex',
  },
  iconGrid: {
    position: 'relative',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center'
  },
  iconContainer: {
    zIndex: 0,
  },
  line: {
    position: 'absolute',
    left: 'calc(50% - 1px)',
    width: '2px',
    height: '100%',
    backgroundColor: theme.palette.grey.A100,
  },
  cardContainer: {
    position: 'relative',
  },
  cardDecoratorLeft: {
    position: 'absolute',
    width: 0,
    height: 0,
    borderTop: '16px solid transparent',
    borderLeft: '16px solid' + theme.palette.grey.A100,
    borderBottom: '16px solid transparent',
    top: 'calc(50% - 16px)',
    left: '100%',
  },
  cardDecoratorRight: {
    position: 'absolute',
    width: 0,
    height: 0,
    borderTop: '16px solid transparent',
    borderRight: '16px solid' + theme.palette.grey.A100,
    borderBottom: '16px solid transparent',
    top: 'calc(50% - 16px)',
    right: '100%',
  }
});

class TimelineBase extends React.Component {
  render() {
    return (
      <Grid container>
        {this.getRows()}
      </Grid>
    );
  }

  getRows() {
    const classes = this.props.classes;
    return this.props.events.map((event, i) => ([
      <Grid item xs={5} key={'left-' + i}>
        {i % 2 === 0 && this.getTimelineElement(event, true)}
      </Grid>,
      <Grid item xs={2} key={'icon-' + i} className={classes.iconGrid}>
        <div className={classes.line} />
        <div className={classes.iconContainer}>
          {event.icon}
        </div>
      </Grid>,
      <Grid item xs={5} key={'right-' + i}>
        {i % 2 !== 0 && this.getTimelineElement(event, false)}
      </Grid>
    ])).reduce((res, grid) => res = [...res, ...grid], []);
  }

  getTimelineElement(event, isLeft) {
    const classes = this.props.classes;

    return (
      <div className={classes.cardContainer}>
        <div className={isLeft ?
          classes.cardDecoratorLeft : classes.cardDecoratorRight} />
        <Card>
          <CardHeader title={event.type} subheader={event.id} />
          <CardContent>
            {event.id}
          </CardContent>
        </Card>
      </div>
    );
  }
}

const Timeline = withStyles(styles)(TimelineBase);

export default Timeline;
