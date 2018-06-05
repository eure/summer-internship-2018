class GithubsController < ApplicationController
  require "open-uri"
  require "nokogiri"

  def index
    url = "https://github.com/trending"
    doc = Nokogiri.HTML(open(url))
    @contents = doc.xpath('//h3').css('a')
    @stars = doc.xpath('//span[@class="d-inline-block float-sm-right"]')
  end

  def show
    @url = "https://github.com" + params[:repo]
    doc = Nokogiri.HTML(open(@url))
    @title = params[:title]
    @detail = doc.xpath('//div[@class="js-repo-meta-container"]').css('span')
    @tags = doc.xpath('//div[@class="js-repo-meta-container"]').css('a')
    @article = doc.xpath('//article')[0]
  end

  def developers
    url = "https://github.com/trending/developers"
    doc = Nokogiri.HTML(open(url))
    @contents = doc.xpath('//h2').css('a')
    @images = doc.xpath('//img')
  end
end
