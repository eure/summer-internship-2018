import Github from '../lib/Github';

export const getGithubTrends = () => {
  return Github.Trend.allLangTrendSearch()
    .then(result => {
      return result.data.trends.map((trend, i) => {
        return { 
          id: `${i+400}`, 
          title: trend.title, 
          language: trend.language ? trend.language : '言語指定なし', 
          star: trend.star, 
          fork: trend.fork, 
          url:  `https://github.com/${trend.title}`,
        };
      });
    });
};