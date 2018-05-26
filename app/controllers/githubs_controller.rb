class GithubsController < ApplicationController
  require "open-uri"
  require "nokogiri"

  def index
    url = "https://github.com/trending"
    doc = Nokogiri.HTML(open(url))
    @contents = doc.xpath('//h3').css('a')
  end
end
