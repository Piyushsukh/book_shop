from rest_framework.views import APIView
from .serializers import RegisterSerializer 
from core.models import User
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import AllowAny,IsAuthenticated
from django.contrib.auth import authenticate
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

            
class LoginView(APIView):
    permission_classes=[AllowAny]
    def post(self,request):
        username=request.data.get("username")
        password=request.data.get("password")
        user=authenticate(username=username,password=password)
        if user is  not None:
            token,create=Token.objects.get_or_create(user=user)
            return Response({
                'token':token.key,
                'user_id':user.id,
                'username':user.username,
            
            },status=status.HTTP_200_OK)
        return Response({'error':'Invalid credential'},status=status.HTTP_401_UNAUTHORIZED)
    

class LogoutView(APIView):
    permission_classes=[IsAuthenticated]

    def post(self,request):
        request.user.auth_token.delete()
        return Response({
            'message':"Logged out successfully"
        },status=status.HTTP_200_OK)
    

class UserView(APIView):
    permission_classes=[IsAuthenticated]

    def get(self,request):
        user=request.user
        return Response({
            'first_name':user.first_name,
            'last_name':user.last_name,
            "username":user.username,
            "email":user.email,
            "is_active":user.is_active
        },status=status.HTTP_200_OK)
    

class PasswordResetView(APIView):
    permission_classes=[IsAuthenticated]

    def post(self,request):
        user=request.user
        old_password=request.data.get('old_password')
        new_password=request.data.get('new_password')

        if not user.check_password(old_password):
            return Response({'error':'old password is incorrect'},status=status.HTTP_404_NOT_FOUND)
         
        if not new_password:
            return Response({'error':'New password is required'},status=status.HTTP_400_BAD_REQUEST)
        
        user.set_password(new_password)
        user.save()
        return Response({'message':'Password updated successfully'},status=status.HTTP_200_OK)