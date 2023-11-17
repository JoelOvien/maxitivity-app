import 'package:ambeego_test/features/auth/presentation/screens/login.screen.dart';
import 'package:ambeego_test/features/navigation/screens/bottom_navigation.screen.dart';
import 'package:ambeego_test/features/onboarding/screens/splash.screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    /// ONBOARDING
    SplashScreen.routeName: (context) => const SplashScreen(),

    /// AUTHENTICATION
    LoginScreen.routeName: (context) => const LoginScreen(),

    /// NAVIGATION
    BottomNavigationScreen.routeName: (context) =>
        const BottomNavigationScreen(),
  };
}
