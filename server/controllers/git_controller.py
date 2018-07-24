import urllib3
from flask import request
from bs4 import BeautifulSoup
import certifi


def SearchGithubTrend() -> list:
    return ParseURL('https://github.com/trending')


def ParseURL(url: str) -> list:
    github_url = "https://github.com"
    http = urllib3.PoolManager(
        cert_reqs='CERT_REQUIRED', ca_certs=certifi.where())

    req = http.request('GET', url)
    soup = BeautifulSoup(req.data, "lxml")
    arr = []
    for title, descrip in zip(soup.find_all(class_="d-inline-block col-9 mb-1"), soup.find_all(class_="col-9 d-inline-block text-gray m-0 pr-4")):
        res = title.find('a')
        # print((res.text).strip() + "\n")
        resp = {}

        resp["description"] = (descrip.text).strip()
        resp["url"] = github_url + title.a.get("href")
        resp["title"] = (res.text).replace(' ', '').strip()
        # print(res.text)
        arr.append(resp)
        # print(descrip.string)
    return arr
    # title = soup.find(class_="d-inline-block col-9 mb-1")
    # descrip = soup.find(class_="col-9 d-inline-block text-gray m-0 pr-4")
    # s = title.find('a')
    # print(s.text)
    # print(descrip.string)


def GithubDetail() -> str:
    url = "https://raw.githubusercontent.com/" + \
        request.args.get('data') + "/master/README.md"

    http = urllib3.PoolManager(
        cert_reqs='CERT_REQUIRED', ca_certs=certifi.where())

    req = http.request('GET', url)
    return (req.data).decode('utf-8')
