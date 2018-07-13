from django.shortcuts import render
from bs4 import BeautifulSoup
import requests

TODAY_URL = "https://github.com/trending?since=daily"
WEEK_URL = "https://github.com/trending?since=weekly"
MONTH_URL = "https://github.com/trending?since=monthly"


def index(request):
    pass


def show(request):
    contents = today()
    result = {
        'result_contents': contents,
    }

    return render(request, 'show.html', result)


def today():
    contents = scraping(TODAY_URL)

    return contents


def week():
    contents = scraping(WEEK_URL)

    return contents


def month():
    contents = scraping(MONTH_URL)

    return contents


def scraping(url):
    request_url = requests.get(url)
    html_text = BeautifulSoup(request_url.text, 'lxml')
    repo_list = html_text.find(class_='repo-list')
    repos = repo_list.find_all(class_='col-12 d-block width-full py-4 border-bottom')

    contents = []

    for repo in repos:
        title = repo.a.text
        url = 'https://github.com' + repo.a.get('href')
        description = repo.find('p', class_='col-9 d-inline-block text-gray m-0 pr-4').text
        lang = repo.find('span', itemprop='programmingLanguage')
        language = lang.string if not isinstance(lang, type(None)) else ''
        star_fork_count = repo.find_all('a', class_='muted-link d-inline-block mr-3')
        star = star_fork_count[0].text
        fork = star_fork_count[1].text

        content = {
            'title': title.strip(),
            'url': url.strip(),
            'description': description.strip(),
            'language': language.strip(),
            'star': star.strip(),
            'fork': fork.strip(),
        }

        contents.append(content)

    return contents
