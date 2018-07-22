from django.urls import path

from . import views

urlpatterns = [
    path('', views.trend, name='trend'),
    path('detail/', views.detail, name='detail'),
    path('developers/', views.trend_developers, name='trend_developers')
]
