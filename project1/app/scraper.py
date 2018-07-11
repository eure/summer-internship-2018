import requests
import re
from bs4 import BeautifulSoup
from .models import GitHubTrend


def trim_figure(text):
    return re.match("[\d,]+", text.get_text().strip()).group().replace(",", "")


def get_trend():
    url = 'https://github.com/trending'

    r = requests.get(url)

    soup = BeautifulSoup(r.text, 'lxml')

    repo_list = soup.select('.repo-list h3 a')
    desc_list = soup.select('div.py-1')
    stars = soup.select('span.d-inline-block.float-sm-right')

    for name, desc, today_star in zip(repo_list, desc_list, stars):
        detail_url = 'https://github.com' + name.get("href")
        r = requests.get(detail_url)
        soup = BeautifulSoup(r.text, 'lxml')
        detail_desc = soup.select('article.markdown-body.entry-content')
        watch = soup.select('ul.pagehead-actions li:nth-of-type(1) a.social-count')
        total_star = soup.select('ul.pagehead-actions li:nth-of-type(2) a.social-count.js-social-count')
        fork = soup.select('ul.pagehead-actions li:nth-of-type(3) a.social-count')

        yield re.sub("^.", "", name.get("href")), desc.get_text().strip(),  \
                trim_figure(today_star), trim_figure(total_star[0]), trim_figure(fork[0]), \
                trim_figure(watch[0]), detail_desc[0].get_text().strip()


if __name__ == '__main__':
    for name, desc, today_star, total_star, fork, watch, detail_desc in get_trend():
        print(name, desc, today_star, detail_desc, total_star, fork, watch)
