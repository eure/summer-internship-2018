FROM python:3.5.2-alpine

ARG project_dir=/home/web/

ADD requirements.txt $project_dir
ADD www/ $project_dir/www

WORKDIR $project_dir

RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN apk update                  
RUN apk add zsh vim git tig

CMD python www/trend.py
