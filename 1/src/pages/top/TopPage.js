import React from 'react';
import styled from 'react-emotion';
import Typography from '@material-ui/core/Typography';
import Input from '@material-ui/core/Input';
import Button from '@material-ui/core/Button';

import EventListItem from './components/EventListItem';

class TopPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      owner: 'facebook',
      repo: 'react',
      eventsData: null,
      hasError: false
    };
  }

  componentDidMount() {
    const { owner, repo } = this.state;
    fetch(`${process.env.REACT_APP_API_BASE_URL}/repos/${owner}/${repo}/issues/events?access_token=${process.env.REACT_APP_ACCESS_TOKEN}`)
      .then(response => {
        if (response.ok) {
          return response.json();
        } else {
          throw new Error();
        }
      })
      .then(data => this.setState({ eventsData: data, hasError: false }))
      .catch(err => {
        this.setState({ hasError: true });
        console.log('errorだぜ');
      });
  }

  handleClick() {
    const { owner, repo } = this.state;
    fetch(`${process.env.REACT_APP_API_BASE_URL}/repos/${owner}/${repo}/issues/events?access_token=${process.env.REACT_APP_ACCESS_TOKEN}`)
      .then(response => {
        if (response.ok) {
          return response.json();
        } else {
          throw new Error();
        }
      })
      .then(data => this.setState({ eventsData: data, hasError: false }))
      .catch(err => {
        this.setState({ hasError: true });
        console.log('errorだぜ');
      });
  }

  render() {
    const { owner, repo, eventsData, hasError } = this.state;

    return (
      <TopPageWrapper>
        <Input placeholder="owner" onChange={e => this.setState({ owner: e.target.value })} />
        <Input placeholder="repo" onChange={e => this.setState({ repo: e.target.value })} />
        <Button color="primary" onClick={() => this.handleClick()}>
          Search
          </Button>
        <Typography variant="display1" color="primary">{owner}/{repo} issues.</Typography>
        {hasError
          ? <Typography variant="subheading" color="default">{owner}/{repo} is not found. Please input correct :owner-name/:repo-name.</Typography>
          : eventsData &&
          <EventListWrapper>
            {eventsData.map((event, index) => <EventListItem owner={owner} repo={repo} key={event.id} event={event} num={index + 1} />)}
          </EventListWrapper>
        }
      </TopPageWrapper>
    );
  }
}

const TopPageWrapper = styled('div')`
  text-align: center;
`;

const EventListWrapper = styled('div')`
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  max-width: 1024px;
  margin: 0 auto;
`;

export default TopPage;
