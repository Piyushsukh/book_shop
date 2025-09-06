from rest_framework.permissions import AllowAny
from rest_framework import generics
from .serializers import SubjectSerializer
from book.models import Subject


class SubjectView(generics.ListAPIView):
    queryset=Subject.objects.all()
    serializer_class=SubjectSerializer
    permission_classes=[AllowAny]