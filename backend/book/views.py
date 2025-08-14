from django.shortcuts import render
from rest_framework import generics
from .models import Book
from .serializers import BookSerializer

class Book(generics.ListCreateAPIView):
    queryset=Book
    serializer_class=BookSerializer
