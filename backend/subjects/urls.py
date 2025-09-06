from django.contrib import admin
from django.urls import path
from .views import SubjectView,FilterSubjectView

urlpatterns = [
    path('',SubjectView.as_view()),
    path('by-subject/',FilterSubjectView.as_view()),
]
