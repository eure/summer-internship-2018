# -*- coding:utf-8 -*-

import requests
import re
from bs4 import BeautifulSoup


def get_trend():
    url = 'https://github.com/trending'

    r = requests.get(url)

    soup = BeautifulSoup(r.text, 'lxml')

    repo_list = soup.select('.repo-list h3 a')
    desc_list = soup.select('div.py-1')
    for repo, desc in zip(repo_list,desc_list):
        detail_url = 'https://github.com' + repo.get("href")
        r = requests.get(detail_url)
        soup = BeautifulSoup(r.text, 'lxml')
        detail_desc = soup.select('article.markdown-body.entry-content')

        yield re.sub("^.","",repo.get("href")), desc.get_text().strip(), detail_desc[0].get_text().strip()


if __name__ == '__main__':
    for repo,desc,detail_desc in get_trend():
        print(repo,desc,detail_desc)
