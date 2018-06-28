require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, 'log/cron.log'
set :environment, Rails.env.to_sym


every 6.hour do
  rake "crawler:reset_status"
  rake "crawler:fetch_url"
  rake "crawler:build_pages"
end
