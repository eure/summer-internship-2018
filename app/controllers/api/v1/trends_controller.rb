class Api::V1::TrendsController < ApplicationController
  # lib/scrape/github.rbを読み込み
  require 'scrape/github'
  # Githubの情報をscrapeするモジュールを読み込む
  include GithubScrape
  def index
    @data = GithubScrape.getTrends
      .map {|trend| trend.transform_keys(&:to_sym)}.to_ary
  end
  
  def show
    # urlに指定されたパラメーターを取得
    user_name = params[:user]
    repo_name = params[:repository]
    # Github Repositryから情報を取得
    @data = GithubScrape.getDescription(user_name, repo_name)
      .map {|repo| repo.transform_keys(&:to_sym)}.to_ary
  end
end
