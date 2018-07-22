import React from 'react';
import styled from 'react-emotion';
import Typography from '@material-ui/core/Typography';
import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import Avatar from '@material-ui/core/Avatar';

/**
 * {
 *   "id": 1745984857,
 *   "node_id": "MDExOkNsb3NlZEV2ZW50MTc0NTk4NDg1Nw==",
 *   "url": "https://api.github.com/repos/airbnb/javascript/issues/events/1745984857",
 *   "actor": {
 *       "login": "EddyVinck",
 *       "id": 23434753,
 *       "node_id": "MDQ6VXNlcjIzNDM0NzUz",
 *       "avatar_url": "https://avatars2.githubusercontent.com/u/23434753?v=4",
 *       "gravatar_id": "",
 *       "url": "https://api.github.com/users/EddyVinck",
 *       "html_url": "https://github.com/EddyVinck",
 *       "followers_url": "https://api.github.com/users/EddyVinck/followers",
 *       "following_url": "https://api.github.com/users/EddyVinck/following{/other_user}",
 *       "gists_url": "https://api.github.com/users/EddyVinck/gists{/gist_id}",
 *       "starred_url": "https://api.github.com/users/EddyVinck/starred{/owner}{/repo}",
 *       "subscriptions_url": "https://api.github.com/users/EddyVinck/subscriptions",
 *       "organizations_url": "https://api.github.com/users/EddyVinck/orgs",
 *       "repos_url": "https://api.github.com/users/EddyVinck/repos",
 *       "events_url": "https://api.github.com/users/EddyVinck/events{/privacy}",
 *       "received_events_url": "https://api.github.com/users/EddyVinck/received_events",
 *       "type": "User",
 *       "site_admin": false
 *   },
 *   "event": "closed",
 *   "commit_id": null,
 *   "commit_url": null,
 *   "created_at": "2018-07-21T06:52:19Z",
 *   "issue": {
 *       "url": "https://api.github.com/repos/airbnb/javascript/issues/1872",
 *       "repository_url": "https://api.github.com/repos/airbnb/javascript",
 *       "labels_url": "https://api.github.com/repos/airbnb/javascript/issues/1872/labels{/name}",
 *       "comments_url": "https://api.github.com/repos/airbnb/javascript/issues/1872/comments",
 *       "events_url": "https://api.github.com/repos/airbnb/javascript/issues/1872/events",
 *       "html_url": "https://github.com/airbnb/javascript/issues/1872",
 *       "id": 343089590,
 *       "node_id": "MDU6SXNzdWUzNDMwODk1OTA=",
 *       "number": 1872,
 *       "title": "Possible mistake in example 4.7 Use return statements in array method callbacks",
 *       "user": {
 *           "login": "EddyVinck",
 *           "id": 23434753,
 *           "node_id": "MDQ6VXNlcjIzNDM0NzUz",
 *           "avatar_url": "https://avatars2.githubusercontent.com/u/23434753?v=4",
 *           "gravatar_id": "",
 *           "url": "https://api.github.com/users/EddyVinck",
 *           "html_url": "https://github.com/EddyVinck",
 *           "followers_url": "https://api.github.com/users/EddyVinck/followers",
 *           "following_url": "https://api.github.com/users/EddyVinck/following{/other_user}",
 *           "gists_url": "https://api.github.com/users/EddyVinck/gists{/gist_id}",
 *           "starred_url": "https://api.github.com/users/EddyVinck/starred{/owner}{/repo}",
 *           "subscriptions_url": "https://api.github.com/users/EddyVinck/subscriptions",
 *           "organizations_url": "https://api.github.com/users/EddyVinck/orgs",
 *           "repos_url": "https://api.github.com/users/EddyVinck/repos",
 *           "events_url": "https://api.github.com/users/EddyVinck/events{/privacy}",
 *           "received_events_url": "https://api.github.com/users/EddyVinck/received_events",
 *           "type": "User",
 *           "site_admin": false
 *       },
 *       "labels": [],
 *       "state": "closed",
 *       "locked": false,
 *       "assignee": null,
 *       "assignees": [],
 *       "milestone": null,
 *       "comments": 2,
 *       "created_at": "2018-07-20T12:29:59Z",
 *       "updated_at": "2018-07-21T06:52:19Z",
 *       "closed_at": "2018-07-21T06:52:19Z",
 *       "author_association": "NONE",
 *       "body": "[4.7](https://github.com/airbnb/javascript#arrays--callback-return) Use return statements in array method callbacks.\r\n\r\n`acc[index] = flatten;` makes no difference for the output in the second (good) example. Should this line be removed or am I missing something here?\r\n\r\nThis is currently in the docs. \r\n```js\r\n// bad - no returned value means `acc` becomes undefined after the first iteration\r\n[[0, 1], [2, 3], [4, 5]].reduce((acc, item, index) => {\r\n  const flatten = acc.concat(item);\r\n  acc[index] = flatten;\r\n});\r\n\r\n// good\r\n[[0, 1], [2, 3], [4, 5]].reduce((acc, item, index) => {\r\n  const flatten = acc.concat(item);\r\n  acc[index] = flatten; \r\n  return flatten;\r\n});\r\n```\r\n\r\nI am suggesting this:\r\n```js\r\n// better?\r\n[[0, 1], [2, 3], [4, 5]].reduce((acc, item) => {\r\n  const flatten = acc.concat(item);\r\n  return flatten;\r\n});\r\n```\r\n\r\nI can make a PR if you want."
 *   }
 * }
 */

class EventPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      eventData: null
    };
  }

  componentDidMount() {
    const { id } = this.props.match.params;

    fetch(`${process.env.REACT_APP_API_BASE_URL}/repos/airbnb/javascript/issues/events/${id}?access_token=${process.env.REACT_APP_ACCESS_TOKEN}`)
      .then(response => {
        if (response.ok) {
          return response.json();
        } else {
          throw new Error();
        }
      })
      .then(data => this.setState({ eventData: data }))
      .catch(err => {
        this.setState({ eventData: null });
        console.error(err);
      });
  }

  render() {
    const { eventData } = this.state;
    return (
      <EventPageWrapper>
        {eventData &&
          <StyledCard>
            <CardContent>
              <Typography variant="title">{eventData.issue.title}</Typography>

              <UserCaptionWrapper>
                <AvatarWrapper>
                  <Avatar alt={eventData.actor.login} src={eventData.actor.avatar_url} />
                </AvatarWrapper>
                <Typography variant="body2" color="secondary">{eventData.actor.login}</Typography>
              </UserCaptionWrapper>

              <CreatedAtWrapper>
                <Typography variant="caption">{eventData.created_at}</Typography>
              </CreatedAtWrapper>
            </CardContent>

          </StyledCard>
        }
      </EventPageWrapper>
    );
  }
}

const EventPageWrapper = styled('div')`
  max-width: 1024px;
  margin: 0 auto;
`;

const StyledCard = styled(Card)`
  width: 100%;
  margin: 0 auto 12px;
  text-align: left;
`;

const AvatarWrapper = styled('div')`
  margin-right: 12px;

`;

const UserCaptionWrapper = styled('div')`
  display: flex;
  align-items: center;
  justify-content: flex-end;
  max-width: 375px;
  margin: 0 0 12px auto;
`;

const CreatedAtWrapper = styled('div')`
  text-align: right;
`;



export default EventPage;
