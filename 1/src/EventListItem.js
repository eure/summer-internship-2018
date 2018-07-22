import React from 'react';
import { Link } from 'react-router-dom';
import Typography from '@material-ui/core/Typography';
import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import { CardMedia } from '../node_modules/@material-ui/core';

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

const EventListItem = ({ event }) => (
  <Card style={{ margin: '0 auto 14px', textAlign: 'left', width: '300px' }}>
    <Link to={`/events/${event.id}`}>
      <CardMedia image={event.actor.avatar_url} style={{ height: 0, paddingTop: '56.25%' }} />
      <CardContent>
        <Typography variant="title">{event.issue.title}</Typography>
        <Typography variant="display2" color="primary">{event.type}</Typography>
        <Typography>{event.created_at}</Typography>
        <Typography>ID: {event.id}</Typography>
        <Typography>Name: {event.actor.login}</Typography>
      </CardContent>
    </Link>
  </Card>
);

export default EventListItem;