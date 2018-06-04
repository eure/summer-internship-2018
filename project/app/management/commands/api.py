# -*- coding:utf-8 -*-

import requests
from bs4 import BeautifulSoup

def get_trend():
    url = 'https://github.com/trending'

    r = requests.get(url)

    soup = BeautifulSoup(r.text, 'lxml')

    repo_list = soup.select('.repo-list h3 a')
    for e in repo_list:
        yield e.get("href")

if __name__ == '__main__':
    for repo in get_trend():
        print(repo)
