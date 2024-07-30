import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_end_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../chating/chat_screen.dart';
import 'package:intl/intl.dart';

class ChatingScreen extends StatefulWidget {
  @override
  _ChatingScreenState createState() => _ChatingScreenState();
}

class _ChatingScreenState extends State<ChatingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(dateTime);
    String todayFormatted = dateFormat.format(now);
    String yesterdayFormatted = dateFormat.format(now.subtract(Duration(days: 1)));
    if (formattedDate == todayFormatted) {
      return '오늘';
    } else if (formattedDate == yesterdayFormatted) {
      return '어제';
    } else if (now.difference(dateTime).inDays < 7) {
      return DateFormat('EEEE', 'ko_KR').format(dateTime);
    } else if (now.difference(dateTime).inDays < 14) {
      return '지난주 ' + DateFormat('EEEE', 'ko_KR').format(dateTime);
    } else {
      return DateFormat('yyyy-MM-dd').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '채팅',
        leading: null,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('participants', arrayContains: _auth.currentUser!.uid)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final chatDocs = chatSnapshot.data!.docs;
          return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) {
              var chatData = chatDocs[index];
              var lastMessageSender = chatData['lastMessageSender'] == _auth.currentUser!.uid ? '나' : '상대';
              return Column(
                children: [
                  ListTile(
                    title: Text(lastMessageSender + ': ' +chatData['lastMessage'] ?? ''),
                    subtitle: Text((chatData['lastMessageTime'] != null
                        ? formatDate(chatData['lastMessageTime'])
                        : '')),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(chatId: chatData.id),
                        ),
                      );
                    },
                  ),
                  Divider(), // 리스트 항목 구분선
                ],
              );
            },
          );
        },
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}