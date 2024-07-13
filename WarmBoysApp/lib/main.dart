import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/main_screen.dart';
import 'screens/register_page_1.dart';
import 'screens/register_page_2_1.dart';
import 'screens/register_page_2_2.dart';
import 'screens/register_page_3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/main': (context) => MainScreen(),
        '/register1': (context) => RegisterPage1(),
        '/register2_1': (context) => RegisterPage2_1(),
        '/register2_2': (context) => RegisterPage2_2(),
        '/register3': (context) => RegisterPage3(),
      },
    );
  }
}
