from django.urls import path
from rest_framework import routers
from . import views


app_name = 'app'
urlpatterns = [
    path('', views.IndexView.as_view(), name='index'),
    path('<int:pk>', views.DetailView.as_view(), name='detail')
]

router = routers.DefaultRouter()
router.register(r'trends', views.Trends)

