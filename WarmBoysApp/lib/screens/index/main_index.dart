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
  late StreamSubscription<QuerySnapshot> _chatSubscription;

  @override
  void initState() {
    super.initState();
    _listenForNewMessages();
  }

  @override
  void dispose() {
    _chatSubscription.cancel();
    super.dispose();
  }

  void _listenForNewMessages() {
    _chatSubscription = _firestore
        .collection('chats')
        .where('participants', arrayContains: _currentUserId)
        .snapshots()
        .listen((snapshot) {
      bool hasNewMessages = false;
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        var lastMessageReadBy = data['lastMessageReadBy'] as List<dynamic>?;
        var lastMessageSender = data['lastMessageSender'] as String?;
        if (lastMessageSender != _currentUserId && (lastMessageReadBy == null || !lastMessageReadBy.contains(_currentUserId))) {
          hasNewMessages = true;
          break;
        }
      }
      if (mounted) {
        setState(() {
          _hasNewMessages = hasNewMessages;
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
            if (index == 2) {
              _markMessagesAsRead();
            }
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

  void _markMessagesAsRead() {
    _firestore
        .collection('chats')
        .where('participants', arrayContains: _currentUserId)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        var lastMessageReadBy = (data['lastMessageReadBy'] as List<dynamic>?) ?? [];
        if (!lastMessageReadBy.contains(_currentUserId)) {
          lastMessageReadBy.add(_currentUserId);
          doc.reference.update({'lastMessageReadBy': lastMessageReadBy});
        }
      }
      if (mounted) {
        setState(() {
          _hasNewMessages = false;
        });
      }
    });
  }
}