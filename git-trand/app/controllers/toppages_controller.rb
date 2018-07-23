class ToppagesController < ApplicationController
require 'nokogiri'
require 'open-uri'
  def index
    get_trends
    
  end

  def show
    get_trends
    @content = @contents[params[:id]]
    
  end
  
  private
  def get_trends
    url = 'https://github.com/trending'
    
    charset = nil
    html = open(url) do |f|
      charset = f.charset 
      f.read 
    end
    
    
    doc = Nokogiri::HTML.parse(html, nil, charset)
    @titles = []
    @contents = {}
    doc.xpath('//li[@class="col-12 d-block width-full py-4 border-bottom"]').each do |node|
       title =  node.xpath('.//h3/a/@href')[0].text
       title.slice!(0)
       @titles.push(title)
       
    
       
       content = node.xpath('.//p[@class="col-9 d-inline-block text-gray m-0 pr-4"]').text
       content.slice!("\n")
       content.strip!
       @contents[title] = content
      
    end
  end
end

