# Summer Internship 2018

## Purpose

This website uses *GitHub API* to search GitHub users in a specific location.
And you can browse the details of the users in the search result.

## Technologies

The technologies used in this application are:

* SPA framework: [React](https://reactjs.org/)
* AltJS: Babel
* Routing: [React Router](https://reacttraining.com/react-router/)
* UI framework: [Material-UI](https://material-ui.com/)

## Environment Building Manual

Install the necessary packages:

`$ npm install`

Run the application:

`$ npm start`

## System Manual

### Home Page

Type in some location text you want to search for into the **Location** text field.
The location you input can be countries or cities.
After typing in the location text, clicking the **Search Button** on the right of the input **Location** text field will display a list of GitHub users whose locations contain the text you have input.

For every user listed, the information will be organized in a card view.
And here are the information that will display:

* users' avatars
* users' accounts
* users' IDs

### User Details Page

When a user card is clicked, it will go to the page to display this user's detailed information.

In the user details page, this information will display:

* user's avatar
* user's name
* user's GitHub page link
* user's detailed location
* user's repositories count
* user's follower count
* user's following count

And clicking the **Back button** on the top left of the page will go back to the home page.
