from django.shortcuts import render
from django.http import Http404
from bs4 import BeautifulSoup
import requests

TODAY_URL = "https://github.com/trending?since=daily"
WEEK_URL = "https://github.com/trending?since=weekly"
MONTH_URL = "https://github.com/trending?since=monthly"


def index(request):
    pass


def trend(request):
    if "since" in request.GET:
        since = request.GET.get("since")
        if since == 'today':
            contents = scraping(TODAY_URL)
        elif since == 'week':
            contents = scraping(WEEK_URL)
        elif since == 'month':
            contents = scraping(MONTH_URL)
    else:
        since = 'today'
        contents = scraping(TODAY_URL)

    result = {
        'since': since,
        'result_contents': contents,
    }

    return render(request, 'show.html', result)


def detail(request):
    title = request.GET.get("title")
    url = "https://github.com/" + title

    request_url = requests.get(url)
    html_text = BeautifulSoup(request_url.text, 'lxml')
    repo_detail = html_text.find(class_='markdown-body entry-content')

    result = {
        'detail': repo_detail.prettify(),
    }

    return render(request, 'detail.html', result)


def scraping(url):
    request_url = requests.get(url)
    html_text = BeautifulSoup(request_url.text, 'lxml')
    repo_list = html_text.find(class_='repo-list')
    repos = repo_list.find_all(class_='col-12 d-block width-full py-4 border-bottom')

    contents = []

    for repo in repos:
        title = ''.join(repo.a.text.split())
        url = 'https://github.com' + repo.a.get('href')
        description = repo.find('p', class_='col-9 d-inline-block text-gray m-0 pr-4')
        desc = description.text if not isinstance(description, type(None)) else ''
        lang = repo.find('span', itemprop='programmingLanguage')
        language = lang.string if not isinstance(lang, type(None)) else ''
        star_fork_count = repo.find_all('a', class_='muted-link d-inline-block mr-3')
        star = star_fork_count[0].text
        fork = star_fork_count[1].text

        content = {
            'title': title,
            'url': url.strip(),
            'description': desc.strip(),
            'language': language.strip(),
            'star': star.strip(),
            'fork': fork.strip(),
        }

        contents.append(content)

    return contents
