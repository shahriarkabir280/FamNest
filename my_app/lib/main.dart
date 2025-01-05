import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/authentications/loginScreen.dart';
import 'package:my_app/features/splashScreen.dart';
import 'package:my_app/Models/DataModel.dart'; // Import UserState
import 'package:my_app/Models/UserState.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserState()), // Provide UserState
        ChangeNotifierProvider(create: (_) => DataModel()), // Provide DataModel if still used
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => splashScreen(),
          '/home': (context) => loginScreen(),
        },
      ),
    );
  }
}