from rest_framework.permissions import AllowAny
from rest_framework import generics
from .serializers import SubjectSerializer
from book.models import Subject,Book
from book.serializers import BookSerializer


class SubjectView(generics.ListAPIView):
    queryset=Subject.objects.all()
    serializer_class=SubjectSerializer
    permission_classes=[AllowAny]

class FilterSubjectView(generics.ListAPIView):
    serializer_class = BookSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        subject_name = self.request.GET.get('subject')
        if subject_name:
            return Book.objects.filter(subject__name__iexact=subject_name)
        return Book.objects.none()
        

