from rest_framework.permissions import AllowAny
from rest_framework import generics
from .serializers import PublisherSerializer
from book.models import Publisher,Book
from book.serializers import BookSerializer


class PublisherView(generics.ListAPIView):
    queryset=Publisher.objects.all()
    serializer_class=PublisherSerializer
    permission_classes=[AllowAny]

class FilterPublisherView(generics.ListAPIView):
    serializer_class = BookSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        publisher_name = self.request.GET.get('publisher')
        if publisher_name:
            return Book.objects.filter(publisher__name__icontains=publisher_name)
        return Book.objects.none()
        

