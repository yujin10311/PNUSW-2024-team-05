import 'package:flutter/material.dart';
import '../register/register_mate_screen_1.dart';
import '../register/register_mate_screen_2.dart';
import '../register/register_mate_screen_3.dart';
import '../register/register_mate_screen_4.dart';
import '../register/register_mate_screen_5.dart';
import '../register/register_emailpassword_screen_6.dart';
import '../../utils/shared_preferences_helper.dart';

class RegisterMateIndex extends StatefulWidget {
  @override
  _RegisterMateIndexState createState() => _RegisterMateIndexState();
}

class _RegisterMateIndexState extends State<RegisterMateIndex> {
  int _currentIndex = 0;
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      RegisterMateScreen1(onNextPage: _nextPage, onPreviousPage: _previousPage),
      RegisterMateScreen2(onNextPage: _nextPage, onPreviousPage: _previousPage),
      RegisterMateScreen3(onNextPage: _nextPage, onPreviousPage: _previousPage),
      RegisterMateScreen4(onNextPage: _nextPage, onPreviousPage: _previousPage),
      RegisterMateScreen5(onNextPage: _nextPage, onPreviousPage: _previousPage),
      RegisterEmailpasswordScreen6(
          onNextPage: _nextPage, onPreviousPage: _previousPage),
    ]);
  }

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _previousPage() async {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    } else {
      await SharedPreferencesHelper.clearAll();
      print("SharedPreference 초기화 완료");
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
    );
  }
}
