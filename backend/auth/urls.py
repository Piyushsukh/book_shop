from django.urls import path
from . import views

urlpatterns = [
     path('register/',views.RegisterView.as_view(), name='register'), 
    path('login/',views.LoginView.as_view(), name='login'),
    path('logout/',views.LogoutView.as_view(), name='logout'),
    # path('user/', views.UserView.as_view(), name='user'),
    # path('password_change/', views.PasswordChangeView.as_view(), name='password_change'),
    # path('password_reset/', views.PasswordResetView.as_view(), name='password_reset'),
]
