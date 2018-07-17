from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('trend/', views.trend, name='trend'),
    path('detail/', views.detail, name='detail')
]
