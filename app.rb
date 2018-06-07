require File.dirname(__FILE__) + "/RssItem"
require 'sinatra'
require 'sinatra/reloader'

url = "http://reco-photo.com/feed"
reco = RssItem.new(url)

get '/' do
  @posts = reco.posts
  erb :index
end
