namespace :scraping do
  desc 'GuthubTrendの内容をスクレイピングしてdbに保存する'
  task fetch_github_trend: :environment do
    data_reset

    fetch_github_trend('https://github.com/trending', 'TodayTrendRepositorie')
    fetch_github_trend('https://github.com/trending?since=weekly', 'WeekTrendRepositorie')
    fetch_github_trend('https://github.com/trending?since=monthly', 'MonthTrendRepositorie')
  end

  def data_reset
    Repositorie.all.each(&:destroy)
  end

  def fetch_github_trend(url, type)
    html = open(url)

    doc = Nokogiri::HTML.parse(html)
    doc.css('div.explore-content > ol > li').each do |node|
      p name = node.css('div.d-inline-block.col-9.mb-1').inner_text.delete(' ').strip
      discription = node.css('div.py-1').inner_text.strip

      Repositorie.create(type: type, name: name, discription: discription)
    end
  end
end
