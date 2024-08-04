import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/utils/firebase_helper.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;

  ChatScreen({required this.chatId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? otherUserProfileUrl;

  @override
  void initState() {
    super.initState();
    _loadOtherUserProfile();
  }

  Future<void> _loadOtherUserProfile() async {
    var chatData = await FirebaseFirestore.instance.collection('chats').doc(widget.chatId).get();
    var participants = chatData.data()?['participants'] as List<dynamic>;
    var otherUserId = participants.firstWhere((id) => id != _auth.currentUser!.uid, orElse: () => null);

    if (otherUserId != null) {
      otherUserProfileUrl = await _getUserProfileUrl(otherUserId);
      setState(() {});
    }
  }

  Future<String?> _getUserProfileUrl(String userId) async {
    final doc = await FirebaseFirestore.instance.collection('user').doc(userId).get();
    if (doc.exists) {
      return doc['imgUrl'];
    }
    return 'assets/images/default_profile.png'; // 기본 이미지 경로
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      await FirebaseHelper.sendMessage(
        chatId: widget.chatId,
        text: _controller.text,
        senderId: _auth.currentUser!.uid,
      );
      _controller.clear();
    }
  }

  String formatDate(Timestamp timestamp) {
    return FirebaseHelper.formatDate(timestamp.toDate());
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
            var chatData = snapshot.data?.data() as Map<String, dynamic>?;
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
                  .orderBy('createdAt', descending: false)
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final chatDocs = chatSnapshot.data?.docs ?? [];
                DateTime? previousDate;

                return ListView.builder(
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, index) {
                    var message = chatDocs[index].data() as Map<String, dynamic>;
                    bool isMe = message['senderId'] == _auth.currentUser!.uid;
                    DateTime messageDate = (message['createdAt'] as Timestamp).toDate();
                    bool showDateSeparator = false;

                    if (previousDate == null || previousDate!.day != messageDate.day) {
                      showDateSeparator = true;
                      previousDate = messageDate;
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showDateSeparator)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    ),
                                  ),
                                ),
                                Text(
                                  formatDate(Timestamp.fromDate(messageDate)),
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Align(
                          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              if (!isMe)
                                CircleAvatar(
                                  radius: 22,
                                  backgroundImage: otherUserProfileUrl != null && otherUserProfileUrl!.isNotEmpty
                                      ? NetworkImage(otherUserProfileUrl!)
                                      : const AssetImage('assets/images/default_profile.png') as ImageProvider,
                                ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isMe ? Colors.green[300] : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  children: [
                                    Text(message['text']),
                                    Text(
                                      message['createdAt'].toDate().toString().substring(11, 16),
                                      style: TextStyle(fontSize: 10, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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