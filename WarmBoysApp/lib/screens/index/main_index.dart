import 'package:flutter/material.dart';
import '../main/home_screen.dart';
import '../main/matching_screen.dart';
import '../main/chating_screen.dart';
import '../main/exchange_screen.dart';

class MainIndex extends StatefulWidget {
  @override
  _MainIndexState createState() => _MainIndexState();
}

class _MainIndexState extends State<MainIndex> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    MatchingScreen(),
    ChatingScreen(),
    ExchangeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home.png', width: 24, height: 24),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon:
                Image.asset('assets/icons/matching.png', width: 24, height: 24),
            label: '매칭',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/chat.png', width: 24, height: 24),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon:
                Image.asset('assets/icons/exchange.png', width: 24, height: 24),
            label: '교환',
          ),
        ],
        selectedItemColor: Colors.blue, // 선택된 아이템 색상
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이템 색상
        showUnselectedLabels: true, // 선택되지 않은 아이템의 레이블도 표시
      ),
    );
  }
}
