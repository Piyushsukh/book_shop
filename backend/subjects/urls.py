from django.contrib import admin
from django.urls import path
from .views import SubjectView

urlpatterns = [
    path('',SubjectView.as_view()),
]
