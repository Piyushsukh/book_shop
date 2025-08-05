from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseAdminSite
from core.models import User

@admin.register(User)
class CustomAdminSite(BaseAdminSite):
    pass

