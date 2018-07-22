import React from 'react';
import Typography from '@material-ui/core/Typography';

import EventListItem from './components/EventListItem';

const API_CALL_URL =
  `${process.env.REACT_APP_API_BASE_URL}/repos/airbnb/javascript/issues/events?access_token=${process.env.REACT_APP_ACCESS_TOKEN}`;

class TopPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      eventsData: null
    };
  }

  componentDidMount() {
    fetch(API_CALL_URL)
      .then(response => response.json())
      .then(data => this.setState({ eventsData: data }))
      .catch(err => {
        console.log('errorだぜ');
      });
  }

  render() {
    const { eventsData } = this.state;

    return (
      <div style={{ textAlign: 'center' }}>
        <Typography variant="display1" color="primary">airbnb/javascript issues events</Typography>
        {eventsData &&
          <div style={{ display: 'flex', flexWrap: 'wrap', justifyContent: 'space-around', margin: '0 auto', maxWidth: '1024px' }}>
            {eventsData.map((event, index) => <EventListItem key={event.id} event={event} num={index + 1} />)}
          </div>
        }
      </div>
    );
  }
}

export default TopPage;
