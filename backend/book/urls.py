from django.contrib import admin
from django.urls import path,include
from .views import BookView,MyBookView

urlpatterns = [
    path('',BookView.as_view()),
    path('my-books/',MyBookView.as_view())
]

