require 'nokogiri'
require 'open-uri'
require 'openssl'

# スクレイプしたいページ
url = 'https://github.com/trending'
# 指定されたページの読み込み
html = open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE).read

# Parse
doc = Nokogiri::HTML(html)
doc.xpath('//ol[@class="repo-list"]/li').each do |node|
  puts "title:" + node.css('div/h3/a').inner_text.strip
  puts "language:" + node.css('span[@itemprop="programmingLanguage"]').inner_text.strip
  puts "star:" + node.css('a[@href$="stargazers"]').inner_text.strip
  puts "fork:" + node.css('a[@href$="network"]').inner_text.strip
  puts "--------------------------------"
end
