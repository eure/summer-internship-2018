require 'nokogiri'
require 'openssl'
require 'open-uri'

module GithubScrape
  def self.getTrends
    trends = []
    keys = ['title', 'language', 'star', 'fork']
    # スクレイプしたいページ
    url = 'https://github.com/trending'
    # 指定されたページの読み込み
    html = open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE).read
    # Parse
    doc = Nokogiri::HTML(html)
    doc.xpath('//ol[@class="repo-list"]/li').each do |node|
      title = node.css('div/h3/a').inner_text.strip
      language = node.css('span[@itemprop="programmingLanguage"]').inner_text.strip
      star = node.css('a[@href$="stargazers"]').inner_text.strip
      fork_ = node.css('a[@href$="network"]').inner_text.strip
      trends.push(Hash[keys.zip [title, language, star, fork_]])
    end
    return trends
  end
end