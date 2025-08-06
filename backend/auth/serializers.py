from rest_framework import serializers

from rest_framework.authtoken.models import Token
from core.models import User

class RegisterSerializer(serializers.ModelSerializer):
    confirm_password=serializers.CharField(write_only=True)

    class Meta:
        model=User
        fields=["username", "email", "password", "confirm_password"]
        extra_kwargs={
            'password':{"write_only":True},
        }

    def save(self):
        password = self.validated_data['password']
        confirm_password = self.validated_data['confirm_password']
        if password!=confirm_password:
            raise serializers.ValidationError({"password": "Passwords do not match."})
        
        user=User(
            email=self.validated_data['email'],
            username=self.validated_data['username']
        )

        user.set_password(password)
        user.save() 
        token,create=Token.objects.get_or_create(user=user)
        return user
        