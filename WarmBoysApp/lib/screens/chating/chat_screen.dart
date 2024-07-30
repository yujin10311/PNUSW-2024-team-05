import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;

  ChatScreen({required this.chatId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('chats').doc(widget.chatId).collection('messages').add({
        'text': _controller.text,
        'createdAt': Timestamp.now(),
        'senderId': _auth.currentUser!.uid,
      });
      await FirebaseFirestore.instance.collection('chats').doc(widget.chatId).update({
        'lastMessage': _controller.text,
        'lastMessageTime': Timestamp.now(),
        'lastMessageSender': _auth.currentUser!.uid,
      });
      _controller.clear();
    }
  }

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
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('chats').doc(widget.chatId).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            var chatData = snapshot.data!.data() as Map<String, dynamic>?;
            if (chatData == null) {
              return Text('Loading...');
            }
            var participants = chatData['participants'] as List<dynamic>;
            var otherUserId = participants.firstWhere(
              (id) => id != _auth.currentUser!.uid,
              orElse: () => null,
            );
            if (otherUserId == null) {
              return Text('No other participant');
            }
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('user').doc(otherUserId).get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                var userData = userSnapshot.data?.data() as Map<String, dynamic>?;
                return Text(userData?['username'] ?? 'Unknown');
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.chatId)
                  .collection('messages')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final chatDocs = chatSnapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, index) {
                    var message = chatDocs[index].data() as Map<String, dynamic>;
                    bool isMe = message['senderId'] == _auth.currentUser!.uid;
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.orange[300] : Colors.blue[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(message['text']),
                            Text(
                              message['createdAt'].toDate().toString().substring(11, 16), // 시간:분까지만 표시
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: '메시지 입력...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}