from django.db import models

class Subject(models.Model):
    name=models.CharField()

class Author(models.Model):
    name=models.CharField()

class Publisher(models.Model):
    name=models.CharField()

class Book(models.Model):
    name=models.CharField()
    price=models.IntegerField()
    discount=models.IntegerField()
    image=models.ImageField()
    preview=models.FileField()
    last_sold=models.DateTimeField()
    subject=models.ForeignKey(Subject,on_delete=models.PROTECT)
    author=models.ForeignKey(Author,on_delete=models.PROTECT)
    publisher=models.ForeignKey(Author,on_delete=models.PROTECT)


