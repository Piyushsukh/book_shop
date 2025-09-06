from rest_framework.permissions import AllowAny
from rest_framework import generics
from .serializers import AuthorSerializer
from rest_framework.response import Response
from book.models import Author,Book
from book.serializers import BookSerializer


class AuthorView(generics.ListAPIView):
    queryset=Author.objects.all()
    serializer_class=AuthorSerializer
    permission_classes=[AllowAny]

class FilterAuthorView(generics.ListAPIView):
    serializer_class = BookSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        author_name = self.request.GET.get('author')
        if author_name:
            return Book.objects.filter(author__name__icontains=author_name)
        return Book.objects.none()
        

