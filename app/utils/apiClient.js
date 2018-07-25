import axios from 'axios';

const githubClient = axios.create({
  baseURL: 'https://github.com',
  timeout: 5000
});

export {
  githubClient
};