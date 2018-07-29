require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, 'log/cron.log'

every 3.hours do
  rake 'scraping:fetch_github_trend'
end
