from django.shortcuts import render
from rest_framework import generics
from .models import Book
from .serializers import BookSerializer,MyBookSeralizer
from rest_framework.permissions import AllowAny, IsAuthenticated


class BookView(generics.ListCreateAPIView):
    queryset=Book.objects.all()
    serializer_class=BookSerializer

    def get_permissions(self):
        if self.request.method=='GET':
            return [AllowAny()]
        return [IsAuthenticated()]
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class MyBookView(generics.ListAPIView):
    serializer_class=MyBookSeralizer
    permission_classes=[IsAuthenticated]

    def get_queryset(self):
        return Book.objects.filter(user=self.request.user)