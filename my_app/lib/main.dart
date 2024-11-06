import 'package:flutter/material.dart';
import 'loading_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'contact_us_screen.dart';
import 'about_us_screen.dart';

void main() {
  runApp(MaterialApp(
    home: LoadingScreen(), // Initial screen with loading spinner
    routes: {
      '/home': (context) => HomeScreen(), // Home screen route
      '/login': (context) => LoginScreen(), // Login screen route
      '/contact': (context) => ContactUsScreen(), // Contact Us screen route
      '/about': (context) => AboutUsScreen(), // About Us screen route
    },
  ));
}
