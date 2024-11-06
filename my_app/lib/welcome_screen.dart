import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String username;
  WelcomeScreen(this.username);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Screen'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.jpeg'), // Add your logo here
        ),
      ),
      body: Center(
        child: Text('Hello $username', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
