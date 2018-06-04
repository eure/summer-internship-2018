# -*- coding:utf-8 -*-

import requests
from bs4 import BeautifulSoup

def get_trend():
    url = 'https://github.com/trending'

    r = requests.get(url)

    soup = BeautifulSoup(r.text, 'lxml')

    repo_list = soup.select('.repo-list h3 a')
    desc_list = soup.select('div.py-1')
    for repo,desc in zip(repo_list,desc_list):
        yield repo.get("href"), desc.get_text().strip()

if __name__ == '__main__':
    for repo,desc in get_trend():
        print(repo,desc)
