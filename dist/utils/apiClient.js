'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.githubClient = undefined;

var _axios = require('axios');

var _axios2 = _interopRequireDefault(_axios);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var githubClient = _axios2.default.create({
  baseURL: 'https://github.com',
  timeout: 2000
});

exports.githubClient = githubClient;