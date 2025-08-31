from django.db import models
from core.models import User


class Subject(models.Model):
    name=models.CharField(unique=True)
    def __str__(self):
        return self.name

class Author(models.Model):
    name=models.CharField(unique=True)
    def __str__(self):
        return self.name

class Publisher(models.Model):
    name=models.CharField(unique=True)
    def __str__(self):
        return self.name

class Book(models.Model):
    name=models.CharField()
    price=models.IntegerField()
    discount=models.IntegerField()
    image=models.ImageField(null=True,upload_to='books/')
    preview=models.FileField(null=True)
    last_sold=models.DateField(null=True)
    publish_date=models.DateField(null=True)
    subject=models.ForeignKey(Subject,on_delete=models.PROTECT,null=True)
    author=models.ForeignKey(Author,on_delete=models.PROTECT,null=True)
    publisher=models.ForeignKey(Publisher,on_delete=models.PROTECT,null=True)
    user=models.ForeignKey(User,on_delete=models.PROTECT,null=True)
    def __str__(self):
        return self.name


