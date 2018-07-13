import axios from 'axios';

const githubClient = axios.create({
  baseURL: 'https://github.com',
  timeout: 2000
});

export {
  githubClient
};