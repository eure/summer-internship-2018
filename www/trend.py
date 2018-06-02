#coding:utf-8
from flask import Flask, render_template
import urllib.request
import json
import urllib.parse

app = Flask(__name__)

#jsonパース
def get_trend(url):
    global content
    response = urllib.request.urlopen(url)
    content = json.loads(response.read().decode('utf8'))
    return content

#リポジトリ情報取得
def get_data(data_type):
    data_list = []
    for contents in content["items"]:
        data_list.append(contents[data_type])
    return data_list

#README取得
def get_readme(url):
    response = urllib.request.urlopen(url)
    data = response.read()
    request = urllib.request.Request('https://api.github.com/markdown/raw')
    request.add_header('Content-Type','text/plain')
    f = urllib.request.urlopen(request,data)
    panel_content = f.read().decode('utf-8')
    return panel_content

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/<find_type>')
def daily_trend(find_type):
    url = 'https://trendings.herokuapp.com/repo?&since=%s' % (find_type)
    get_trend(url)
    return render_template('%s.html' % (find_type),table_content = zip(get_data("repo"),get_data("added_stars")))

@app.route('/trend/<int:post_id>')
def show_post(post_id):
    #README.mdのURL生成
    url = 'https://raw.githubusercontent.com/%s/master/README.md' % (get_data("repo")[post_id-1])
    return render_template('repo_detail.html',name = get_data("repo")[post_id-1],desc = get_data("desc")[post_id-1],panel_content = get_readme(url),repolink = get_data("repo_link")[post_id-1],forks = get_data("forks")[post_id-1],stars = get_data("stars")[post_id-1],lang=get_data("lang")[post_id-1])


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
