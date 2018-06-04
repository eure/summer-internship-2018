from django.shortcuts import render
from app.models import TrendRepo
from django.views import generic

# Create your views here.
def index(request):
    trend_list = TrendRepo.objects.all()
    return render(request,'app/index.html',{'trend_list':trend_list})

def detail(request,pk):
    trend = TrendRepo.objects.get(id=pk)
    return render(request,'app/detail.html',{'trend':trend})

