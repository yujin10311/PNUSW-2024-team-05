import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/main_screen.dart';
import 'screens/register_page_1.dart';
import 'screens/register_page_2.dart';
import 'providers/register_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RegisterProvider(
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/main': (context) => MainScreen(),
          '/register1': (context) => RegisterPage1(),
          '/register2': (context) => RegisterPage2(),
        },
      ),
    );
  }
}
