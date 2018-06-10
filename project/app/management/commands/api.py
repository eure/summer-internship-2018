# -*- coding:utf-8 -*-

# Githubトレンド取得のクローラー
import requests
import re
from bs4 import BeautifulSoup

def trim_figure(text):
    return re.match("[\d,]+", text.get_text().strip()).group().replace(",","")

def get_trend():
    url = 'https://github.com/trending'

    r = requests.get(url)

    soup = BeautifulSoup(r.text, 'lxml')

    repo_list = soup.select('.repo-list h3 a')
    desc_list = soup.select('div.py-1')
    stars = soup.select('span.d-inline-block.float-sm-right')
    for repo,desc,star in zip(repo_list,desc_list,stars):
        detail_url = 'https://github.com' + repo.get("href")
        r = requests.get(detail_url)
        soup = BeautifulSoup(r.text, 'lxml')
        detail_desc = soup.select('article.markdown-body.entry-content')
        watch = soup.select('ul.pagehead-actions li:nth-of-type(1) a.social-count')
        total_star = soup.select('ul.pagehead-actions li:nth-of-type(2) a.social-count.js-social-count')
        fork = soup.select('ul.pagehead-actions li:nth-of-type(3) a.social-count')

        yield re.sub("^.","",repo.get("href")), desc.get_text().strip(),  \
                trim_figure(star), detail_desc[0].get_text().strip(), \
                trim_figure(total_star[0]),trim_figure(fork[0]),trim_figure(watch[0])

if __name__ == '__main__':
    for repo,desc,star,detail_desc,total_star,fork,watch in get_trend():
        print(repo,desc,star,detail_desc,total_star,fork,watch)
