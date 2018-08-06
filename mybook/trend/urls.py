from django.urls import path
from trend import views


app_name = 'trend'
urlpatterns = [
    path('', views.index, name='index'),
    path('<int:n>', views.detail, name='detail')
]