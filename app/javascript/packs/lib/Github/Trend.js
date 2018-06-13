import axios from 'axios';

const RAILS_GITHUBTREND_ENDPOINT = '/api/v1/trends';

export default {
  allLangTrendSearch: () =>
    axios.get(RAILS_GITHUBTREND_ENDPOINT),
};