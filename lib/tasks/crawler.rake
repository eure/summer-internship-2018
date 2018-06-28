namespace :crawler do

  desc 'Reset article status'
  task reset_status: :environment do
    puts "====reset article status===="
    Article.all.each do |article|
      article.update!(status: :close)
    end
  end

  desc 'Fetch each page url'
  task fetch_url: :environment do
    puts "====building master...===="
    charset = nil
    html = open("https://github.com/trending") do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)
    puts doc.title
    i = 0
    doc.xpath('//div/ol/li/div/h3/a/@href').each do |node|
      s = node.text.split("/")
      name = s[1] + "/" + s[2]
      i += 1
      article = Article.find_or_create_by(url: "https://github.com#{node.inner_text}")
      article.update!(name: name, ranking: i, status: :open)
    end
  end

  desc 'Update each article'
  task build_pages: :environment do
    puts "====building each pages...===="
    charset = nil
    urls = Article.open.pluck(:url)
    urls.each do |url|
      html = open(url) do |f|
        charset = f.charset
        f.read
      end
      doc = Nokogiri::HTML.parse(html, nil, charset)
      puts doc.title
      a = Article.find_by(url: url)
      dcrp = doc.title.split(a.name+":")[1]
      readme = ""
      doc.xpath('//div[@id="readme"]/article').each do |node|
        readme = node.inner_text
      end
      a.update!(description: dcrp, readme: readme)
    end
  end

end
