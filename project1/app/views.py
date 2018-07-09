import django_filters
from rest_framework import viewsets, filters

from django.shortcuts import render
from django.views import generic
from .models import GitHubTrend
from .serializer import TrendSerializer
from .scraper import get_trend


class Trends(viewsets.ModelViewSet):
    GitHubTrend.objects.all().delete()
    for name, desc, today_star, total_star, fork, watch, detail_desc in get_trend():
        GitHubTrend.objects.create(name=name, desc=desc, today_star=today_star, total_star=total_star,
                                   fork=fork, watch=watch, detail_desc=detail_desc)

    queryset = GitHubTrend.objects.all()
    serializer_class = TrendSerializer


class IndexView(generic.ListView):
    model = GitHubTrend
    context_object_name = 'trend_list'
    template_name = 'app/index.html'


class DetailView(generic.DetailView):
    model = GitHubTrend
    template_name = 'app/detail.html'

