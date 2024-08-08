import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main/home_screen.dart';
import '../main/matching_screen.dart';
import '../main/chatting_screen.dart';
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
    ChattingScreen(),
    ExchangeScreen(),
  ];

  bool _hasNewMessages = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _currentUserId = FirebaseAuth.instance.currentUser!.uid;
  late StreamSubscription<DocumentSnapshot> _subscription;

  @override
  void initState() {
    super.initState();
    _subscribeToNewMessages();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _subscribeToNewMessages() {
    _subscription = _firestore
        .collection('alarms')
        .doc(_currentUserId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          _hasNewMessages = snapshot.data()?['hasNewChat'] ?? false;
        });
      }
    });
  }

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
            icon: Image.asset('assets/icons/matching.png', width: 24, height: 24),
            label: '매칭',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Image.asset('assets/icons/chat.png', width: 24, height: 24),
                if (_hasNewMessages)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                    ),
                  ),
              ],
            ),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/exchange.png', width: 24, height: 24),
            label: '교환',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}