from django.contrib import admin
from django.urls import path
from .views import AuthorView,FilterAuthorView

urlpatterns = [
    path('',AuthorView.as_view()),
    path('by-author/',FilterAuthorView.as_view()),
]
