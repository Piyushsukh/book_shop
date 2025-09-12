
from rest_framework import generics,filters,mixins
from .models import Book
from .serializers import BookSerializer,MyBookSeralizer
from rest_framework.permissions import AllowAny, IsAuthenticated


class BookView(generics.ListCreateAPIView):
    queryset=Book.objects.all()
    serializer_class=BookSerializer
    filter_backends=[filters.SearchFilter]
    search_fields=['name','author__name','publisher__name','subject__name']
    search_param='q'

    def get_permissions(self):
        if self.request.method=='GET':
            return [AllowAny()]
        return [IsAuthenticated()]
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)



class MyBookView(generics.GenericAPIView, 
                 mixins.ListModelMixin, 
                 mixins.DestroyModelMixin):
    serializer_class = MyBookSeralizer
    permission_classes = [IsAuthenticated]

    
    def get_queryset(self):
        return Book.objects.filter(user=self.request.user)
    
    def get(self, request, *args, **kwargs):
        return self.list(request,*args,**kwargs)
    
    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)