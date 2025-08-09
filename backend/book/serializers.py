from .models import Book,Publisher,Author,Subject
from rest_framework import serializers

class BookSerializer(serializers.ModelSerializer):
    author=serializers.StringRelatedField()
    publisher=serializers.StringRelatedField()
    class Meta:
        model=Book
        fields=('name','price','discount','author','publisher',)