from rest_framework.views import APIView
from .serializers import RegisterSerializer 
from core.models import User
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import AllowAny
from rest_framework.authtoken.models import Token


class RegisterView(APIView):
    permission_classes=[AllowAny]
    
    def post(self,request):
        serializer=RegisterSerializer(data=request.data)
        if serializer.is_valid():
            user=serializer.save()
            token,create=Token.objects.get_or_create(user=user)
            return Response({
                "key":token.key,
                "data":serializer.data
            },status=status.HTTP_201_CREATED)
        return Response(status=status.HTTP_400_BAD_REQUEST)

            