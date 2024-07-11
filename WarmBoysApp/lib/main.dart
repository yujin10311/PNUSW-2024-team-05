import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {
        '/main': (context) => MainScreen(),
      },
    );
  }
}
