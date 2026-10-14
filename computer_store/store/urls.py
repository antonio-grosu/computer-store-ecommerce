from django.urls import path
from . import views


urlpatterns = [
    path("", views.index, name = "index"),
    path("info", views.info, name="info"),
    path('exemplu_template', views.exemplu_template, name="exemplu_template"),
    path('exemplu_template2', views.exemplu_template2, name="exemplu_template2")
    
]