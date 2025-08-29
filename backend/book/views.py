from django.shortcuts import render
from rest_framework import generics
from .models import Book
from .serializers import BookSerializer
from rest_framework.permissions import AllowAny, IsAuthenticated


class BookView(generics.ListAPIView):
    queryset=Book.objects.all()
    serializer_class=BookSerializer

    def get_permissions(self):
        if self.request.method=='GET':
            return [AllowAny()]
        return [IsAuthenticated()]