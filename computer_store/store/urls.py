from django.urls import path, re_path
from . import views


urlpatterns = [
    path("", views.index, name="index"),
    path("info", views.info, name="info"),
    path("log", views.log, name="log"),
    re_path(r"^accesare(?P<id_accesare>[0-9]+)$", views.accesare, name="accesare"),
    path("despre", views.despre, name="despre"),
    path("istoric", views.istoric, name="istoric"),
    path("produse", views.produse, name="produse"),
    path("configurator", views.configurator, name="configurator"),
    path("service", views.service, name="service"),
    path("contact", views.contact, name="contact"),
    path("cos_virtual", views.cos_virtual, name="cos_virtual"),
    path('exemplu_template', views.exemplu_template, name="exemplu_template"),
    path('exemplu_template2', views.exemplu_template2, name="exemplu_template2")
]
