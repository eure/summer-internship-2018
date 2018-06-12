import Github from '../lib/Github';

export const getGithubRepositoryInfo = (user, repository) => {
  return Github.Repository.repositoryInfoSearch(user, repository)
    .then(result => {
      console.log(result);
      return {
        description: result.data.repository[0].description,
        userImage: result.data.repository[0].userImage,
      };
    });
};