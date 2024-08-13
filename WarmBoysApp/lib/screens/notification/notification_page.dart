import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '/../providers/custom_auth_provider.dart';
import '../chatting/chat_screen.dart';
import '../main/matching_screen.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _selectedCategory = '공고 알림';

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<CustomAuthProvider>(context, listen: false).uid;

    if (userId == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('알림'),
        ),
        body: Center(
          child: Text('로그인이 필요합니다.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('알림'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: <String>['공고 알림', '채팅 알림']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('alarms')
                  .doc(userId)
                  .collection('userAlarms')
                  .where('alarmType', isEqualTo: _selectedCategory == '공고 알림' ? 'post' : 'chat')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var alarms = snapshot.data!.docs;

                if (alarms.isEmpty) {
                  return Center(child: Text('새로운 알림이 없습니다.'));
                }

                return ListView.builder(
                  itemCount: alarms.length,
                  itemBuilder: (context, index) {
                    var alarm = alarms[index].data() as Map<String, dynamic>;
                    var alarmId = alarms[index].id;

                    return ListTile(
                      title: Text(alarm['message']),
                      subtitle: Text(
                        DateFormat('yyyy-MM-dd HH:mm')
                            .format(alarm['timestamp'].toDate()),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('alarms')
                              .doc(userId)
                              .collection('userAlarms')
                              .doc(alarmId)
                              .update({'read': true});
                          setState(() {});
                        },
                      ),
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection('alarms')
                            .doc(userId)
                            .collection('userAlarms')
                            .doc(alarmId)
                            .update({'read': true});

                        if (_selectedCategory == '채팅 알림') {
                          // 채팅 알림일 경우 채팅 화면으로 이동
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                chatId: alarm['chatId'],
                              ),
                            ),
                          );
                        } else if (_selectedCategory == '공고 알림') {
                          // 공고 알림일 경우 매칭 화면으로 이동
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchingScreen(),
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}