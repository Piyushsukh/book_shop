from rest_framework import serializers
from django.contrib.auth.models import User

class RegisterSerializer(serializers.ModelSerializer):
    confirm_password=serializers.CharField(style='{"input_type}:"password"}',write_only=True)

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