import axios from 'axios';

const RAILS_GITHUBTREND_ENDPOINT = '/api/v1/trends/repository';

// URLのパラメーターをセット
const setParams = (user, repository) => {
  return ("?user="+user+"&repository="+repository);
};

export default {
  repositoryInfoSearch: (user, repository) =>
    axios.get(RAILS_GITHUBTREND_ENDPOINT+setParams(user, repository)),
};