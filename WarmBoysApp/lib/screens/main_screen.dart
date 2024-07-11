import 'package:flutter/material.dart';
import 'home_page.dart';
import 'matching_page.dart';
import 'community_page.dart';
import 'exchange_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    MatchingPage(),
    CommunityPage(),
    ExchangePage(),
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
            icon: Image.asset('assets/icons/community.png',
                width: 24, height: 24),
            label: '커뮤니티',
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
