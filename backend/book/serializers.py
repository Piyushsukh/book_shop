from .models import Book, Publisher, Author, Subject
from rest_framework import serializers
from django.db.models import Q

class BookSerializer(serializers.ModelSerializer):
    author = serializers.CharField()
    publisher = serializers.CharField()
    subject = serializers.CharField()
    image = serializers.ImageField(use_url=True, required=False)

    class Meta:
        model = Book
        fields = (
            'name',
            'price',
            'discount',
            'author',
            'publisher',
            'image',
            'preview',
            'last_sold',
            'publish_date',
            'subject',
        )

    def create(self, validated_data):
        author_name = validated_data.pop("author").strip()
        publisher_name = validated_data.pop("publisher").strip()
        subject_name = validated_data.pop("subject").strip()

        author, _ = Author.objects.get_or_create(
            name__iexact=author_name,
            defaults={"name": author_name}
        )
        publisher, _ = Publisher.objects.get_or_create(
            name__iexact=publisher_name,
            defaults={"name": publisher_name}
        )
        subject, _ = Subject.objects.get_or_create(
            name__iexact=subject_name,
            defaults={"name": subject_name}
        )

        validated_data["author"] = author
        validated_data["publisher"] = publisher
        validated_data["subject"] = subject
        return Book.objects.create(**validated_data)


class AuthorSerializer(serializers.ModelSerializer):

    class Meta:
        model='Author'
        fields=Author.objects.all()