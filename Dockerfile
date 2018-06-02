FROM python:3.5.2-alpine

ARG project_dir=/

ADD requirements.txt $project_dir
COPY www/ .

WORKDIR $project_dir

RUN pip install -r requirements.txt
RUN apk update                  
RUN apk add zsh vim git tig

CMD python ./trend.py
