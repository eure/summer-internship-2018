from django.shortcuts import render
from trend.models import TrendSet
from django.views import generic


# Create your views here.
def index(request):
    trend_list = TrendSet.objects.all()
    return render(request, 'trend/index.html', {'trend_list': trend_list})


def detail(request, n):
    trend = TrendSet.object.get(id=n)
    return render(request, 'trend/detail.html', {'trend': trend})
