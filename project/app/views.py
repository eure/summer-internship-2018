from django.shortcuts import render
from app.models import TrendRepo

# Create your views here.
def index(request):
    trend_list = TrendRepo.objects.all()
    return render(request,'app/index.html',{'trend_list':trend_list})
