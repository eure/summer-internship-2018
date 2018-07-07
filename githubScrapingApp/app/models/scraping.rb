class Scraping
  def self.repository_urls
    agent = Mechanize.new
    links = []

    page = agent.get("https://github.com/trending")

    urls = page.search('h3 a')
    urls.each do |url|
      links << url.get_attribute('href')
    end

    links.each do |link|
      get_information("https://github.com" + link)
    end
  end

  def self.get_information(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('h1 strong a').inner_text if page.at('h1 strong a')

    description = page.at('.repository-meta-content span').inner_text if page.at('.repository-meta-content span')
    url = link
    account = page.at('h1 .author a').inner_text if page.at('h1 .author a')
    star_count = page.at('a[@href$="stargazers"]').inner_text.strip.delete(",")
    fork_count = page.at('a[@href$="network"]').inner_text.strip.delete(",")
    readme = page.at('#readme article').inner_text

    github_info = GithubInfo.where(title: title).first_or_initialize
    github_info.description = description
    github_info.url = url
    github_info.account = account
    github_info.star_count = star_count
    github_info.fork_count = fork_count
    github_info.readme = readme
    github_info.save
  end
end
