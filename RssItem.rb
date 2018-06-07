require 'rss'

class RssItem
  attr_accessor :posts

  def initialize(url)
    @posts = []
    rss = RSS::Parser.parse(url)
    rss.items.each do |item|
      @posts << {
        title: item.title,
        link: item.link,
        date: item.pubDate.strftime("%a, %d %b %Y"),
        description: item.description
      }
    end
  end
end
