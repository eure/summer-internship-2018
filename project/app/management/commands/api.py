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
    stars = soup.select('span.d-inline-block.float-sm-right')
    for repo,desc,star in zip(repo_list,desc_list,stars):
        yield re.sub("^.","",repo.get("href")), desc.get_text().strip(), re.match("[\d,]+",star.get_text().strip()).group().replace(",","")


if __name__ == '__main__':
    for repo,desc,star in get_trend():
        print(repo,desc,star)
