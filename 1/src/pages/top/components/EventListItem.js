import React from 'react';
import styled from 'react-emotion';
import { Link } from 'react-router-dom';
import Typography from '@material-ui/core/Typography';
import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import Avatar from '@material-ui/core/Avatar';

/**
 * Sample event data.
 *
 * {
 *   "id": "7999744917",
 *   "type": "WatchEvent",
 *   "actor": {
 *     "id": 13493529,
 *     "login": "rodrigotrovao",
 *     "display_login": "rodrigotrovao",
 *     "gravatar_id": "",
 *     "url": "https://api.github.com/users/rodrigotrovao",
 *     "avatar_url": "https://avatars.githubusercontent.com/u/13493529?"
 *   },
 *   "repo": {
 *     "id": 41881900,
 *     "name": "Microsoft/vscode",
 *     "url": "https://api.github.com/repos/Microsoft/vscode"
 *   },
 *   "payload": {
 *     "action": "started"
 *   },
 *   "public": true,
 *   "created_at": "2018-07-22T06:45:46Z",
 *   "org": {
 *     "id": 6154722,
 *     "login": "Microsoft",
 *     "gravatar_id": "",
 *     "url": "https://api.github.com/orgs/Microsoft",
 *     "avatar_url": "https://avatars.githubusercontent.com/u/6154722?"
 *   }
 * },
 */

const EventListItem = ({ event, num }) => (
  <StyledCard>
    <Link to={`/events/${event.id}`}>
      <CardContent>
        <Typography variant="display1">{`#${num}`}</Typography>
        <Typography variant="title">{event.issue.title}</Typography>

        <UserCaptionWrapper>
          <AvatarWrapper>
            <Avatar alt={event.actor.login} src={event.actor.avatar_url} />
          </AvatarWrapper>
          <Typography variant="body2" color="secondary">{event.actor.login}</Typography>
        </UserCaptionWrapper>

        <CreatedAtWrapper>
          <Typography variant="caption">{event.created_at}</Typography>
        </CreatedAtWrapper>
      </CardContent>
    </Link>
  </StyledCard>
);

const StyledCard = styled(Card)`
  width: 100%;
  margin: 0 auto 12px;
  text-align: left;
  transition: all 0.3s cubic-bezier(.25,.8,.25,1);
  &:hover {
    box-shadow: 0 12px 24px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
  }`;

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

export default EventListItem;