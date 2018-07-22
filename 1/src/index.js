/* eslint-disable */
require('dotenv').config();

import React from 'react';
import ReactDOM from 'react-dom';
import { injectGlobal } from "react-emotion";
import App from './App';
/* eslint-enable */

// CSSをリセット
injectGlobal(`
  html, body, p {
    padding: 0;
    margin: 0;
  }
  body {
    width: 100%;
    background-color: #fafafa;
  }
  ul {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  button {
    padding: 0;
    margin: 0;
    background-color: transparent;
    border: none;
  }
  a {
    text-decoration: none;
  }
`);


ReactDOM.render(<App />, document.getElementById('root'));
