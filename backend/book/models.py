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
    image=models.ImageField(null=True)
    preview=models.FileField(null=True)
    last_sold=models.DateTimeField(null=True)
    subject=models.ForeignKey(Subject,on_delete=models.PROTECT,null=True)
    author=models.ForeignKey(Author,on_delete=models.PROTECT,null=True)
    publisher=models.ForeignKey(Publisher,on_delete=models.PROTECT,null=True)


