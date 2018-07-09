FROM continuumio/anaconda3
LABEL maintainer "Masato Tonouchi <tonouchi-masato-yh@ynu.jp>"

ARG project_dir=/home/web/

ADD requirements.txt $project_dir
ADD ./ $project_dir/

WORKDIR $project_dir

RUN pip install --upgrade pip && pip install -r requirements.txt
