class TrendsController < ApplicationController
  # lib/scrape/github.rbを読み込み
  require 'scrape/github'
  # Githubの情報をscrapeするモジュールを読み込む
  include GithubScrape
  def index
    # Github Trendingから情報を取得
    @trends = GithubScrape.getTrends
  end
end
