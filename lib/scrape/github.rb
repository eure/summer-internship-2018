require 'nokogiri'
require 'openssl'
require 'open-uri'

module GithubScrape
  # githubtrendingに記載されているrepositoryの情報をスクレイプするメソッド
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
      title = node.css('div/h3/a').inner_text.strip.gsub(" ", "")
      language = node.css('span[@itemprop="programmingLanguage"]').inner_text.strip
      star = node.css('a[@href$="stargazers"]').inner_text.strip.gsub(/(\d{0,3}),(\d{3})/, '\1\2').to_i
      fork_ = node.css('a[@href$="network"]').inner_text.strip.gsub(/(\d{0,3}),(\d{3})/, '\1\2').to_i
      trends.push(Hash[keys.zip [title, language, star, fork_]])
    end
    return trends
  end
  # github repositoryのdescriptionをスクレイプするメソッド
  def self.getDescription(user, repository)
    # スクレイプしたいリポジトリのurl
    url = "https://github.com/#{user}/#{repository}"
    
    # 指定されたページの読み込み
    html = open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE).read
    # Parse
    doc = Nokogiri::HTML(html)
    node_desc = doc.xpath('//div[@class="js-repo-meta-container"]')
    description = node_desc.css('span[@itemprop="about"]').inner_text.strip
    
    # userのプロフィール
    url = "https://github.com/#{user}"
    # 指定されたページの読み込み
    html = open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE).read
    # Parse
    doc = Nokogiri::HTML(html)
    userimage = doc.search('img').first.attribute("src").value
    
    hash = [{description: description, userImage: userimage}]
    return hash
  end
end