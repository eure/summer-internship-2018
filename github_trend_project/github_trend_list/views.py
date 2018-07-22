from django.shortcuts import render
from django.http import Http404
from bs4 import BeautifulSoup
import requests

TREND_TODAY_URL = "https://github.com/trending?since=daily"
TREND_WEEK_URL = "https://github.com/trending?since=weekly"
TREND_MONTH_URL = "https://github.com/trending?since=monthly"

DEVELOPER_TODAY_URL = "https://github.com/trending/developers?since=daily"
DEVELOPER_WEEK_URL = "https://github.com/trending/developers?since=weekly"
DEVELOPER_MONTH_URL = "https://github.com/trending/developers?since=monthly"


def trend(request):
    if "since" in request.GET:
        since = request.GET.get("since")
        if since == 'today':
            contents = trend_scraping(TREND_TODAY_URL)
        elif since == 'week':
            contents = trend_scraping(TREND_WEEK_URL)
        elif since == 'month':
            contents = trend_scraping(TREND_MONTH_URL)
    else:
        since = 'today'
        contents = trend_scraping(TREND_TODAY_URL)

    result = {
        'title': 'repositories',
        'since': since,
        'result_contents': contents,
    }

    return render(request, 'trend.html', result)


def trend_developers(request):
    if "since" in request.GET:
        since = request.GET.get("since")
        if since == 'today':
            contents = developer_scraping(DEVELOPER_TODAY_URL)
        elif since == 'week':
            contents = developer_scraping(DEVELOPER_WEEK_URL)
        elif since == 'month':
            contents = developer_scraping(DEVELOPER_MONTH_URL)
    else:
        since = 'today'
        contents = developer_scraping(DEVELOPER_TODAY_URL)

    result = {
        'title': 'developers',
        'since': since,
        'result_contents': contents,
    }

    return render(request, 'developers.html', result)


def detail(request):
    title = request.GET.get("title")
    url = "https://github.com/" + title

    request_url = requests.get(url)
    html_text = BeautifulSoup(request_url.text, 'lxml')
    repo_detail = html_text.find(class_='markdown-body entry-content')

    result = {
        'url': url,
        'detail': repo_detail.prettify(),
    }

    return render(request, 'detail.html', result)


def trend_scraping(url):
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


def developer_scraping(url):
    request_url = requests.get(url)
    html_text = BeautifulSoup(request_url.text, 'lxml')
    developer_list = html_text.find(class_='explore-content')
    developers = developer_list.find_all(class_='d-sm-flex flex-justify-between border-bottom border-gray-light py-3')

    contents = []

    for developer in developers:
        name = ''.join(developer.find(class_='f3 text-normal').text.split())
        link_and_img = developer.find(class_='d-inline-block')
        url = 'https://github.com' + link_and_img.get('href')
        image = link_and_img.find('img')['src']
        repo_name = developer.find(class_='repo').text.strip()
        repo_url = url + '/' + developer.find(class_='repo').text.strip()
        description = developer.find(class_='repo-snipit-description css-truncate-target').text

        content = {
            'name': name,
            'url': url,
            'image': image,
            'repo_name': repo_name,
            'repo_url': repo_url,
            'description': description,
        }

        contents.append(content)

    return contents
