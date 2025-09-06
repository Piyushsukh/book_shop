from django.contrib import admin
from django.urls import path
from .views import PublisherView,FilterPublisherView

urlpatterns = [
    path('',PublisherView.as_view()),
    path('by-publisher/',FilterPublisherView.as_view()),
]
