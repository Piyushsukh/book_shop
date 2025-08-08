from django.contrib import admin

from book.models import Subject,Author, Publisher,Book

admin.site.register(Subject)
admin.site.register(Author)
admin.site.register(Publisher)
admin.site.register(Book)
