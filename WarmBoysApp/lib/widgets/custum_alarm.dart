import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:warm_boys/providers/custom_auth_provider.dart';
import 'package:intl/intl.dart';

class CustomAlarmButton extends StatefulWidget {
  @override
  _CustomAlarmButtonState createState() => _CustomAlarmButtonState();
}

class _CustomAlarmButtonState extends State<CustomAlarmButton> {
  bool hasNewAlarms = false;
  late StreamSubscription _alarmSubscription;

  @override
  void initState() {
    super.initState();
    _listenForAlarms();
  }

  @override
  void dispose() {
    _alarmSubscription.cancel();
    super.dispose();
  }

  void _listenForAlarms() {
    final userId = Provider.of<CustomAuthProvider>(context, listen: false).uid;
    if (userId != null) {
      _alarmSubscription = FirebaseFirestore.instance
          .collection('alarms')
          .doc(userId)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists && snapshot.data()?['hasNewAlarms'] == true) {
          setState(() {
            hasNewAlarms = true;
          });
        }
      });

      FirebaseFirestore.instance
          .collection('posts')
          .where('seniorUid', isEqualTo: userId)
          .snapshots()
          .listen((snapshot) {
        for (var docChange in snapshot.docChanges) {
          if (docChange.type == DocumentChangeType.modified) {
            FirebaseFirestore.instance.collection('alarms').doc(userId).set({
              'hasNewAlarms': true,
            }, SetOptions(merge: true));
            FirebaseFirestore.instance
                .collection('alarms')
                .doc(userId)
                .collection('userAlarms')
                .add({
              'postId': docChange.doc.id,
              'message': '공고 상태가 변경되었습니다.',
              'timestamp': Timestamp.now(),
            });
          }
        }
      });

      FirebaseFirestore.instance
          .collection('posts')
          .where('mateUid', isEqualTo: userId)
          .snapshots()
          .listen((snapshot) {
        for (var docChange in snapshot.docChanges) {
          if (docChange.type == DocumentChangeType.modified) {
            FirebaseFirestore.instance.collection('alarms').doc(userId).set({
              'hasNewAlarms': true,
            }, SetOptions(merge: true));
            FirebaseFirestore.instance
                .collection('alarms')
                .doc(userId)
                .collection('userAlarms')
                .add({
              'postId': docChange.doc.id,
              'message': 'A post you applied to has been updated.',
              'timestamp': Timestamp.now(),
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () async {
            final userId = Provider.of<CustomAuthProvider>(context, listen: false).uid;
            if (userId != null) {
              setState(() {
                hasNewAlarms = false;
              });
              await FirebaseFirestore.instance.collection('alarms').doc(userId).set({
                'hasNewAlarms': false,
              }, SetOptions(merge: true));

              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('알림 목록'),
                    content: Container(
                      width: double.maxFinite,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 300),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('alarms')
                              .doc(userId)
                              .collection('userAlarms')
                              .orderBy('timestamp', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            var alarms = snapshot.data!.docs;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: alarms.length,
                              itemBuilder: (context, index) {
                                var alarm = alarms[index].data() as Map<String, dynamic>;
                                return ListTile(
                                  title: Text(alarm['message']),
                                  subtitle: Text(
                                    DateFormat('yyyy-MM-dd HH:mm')
                                        .format(alarm['timestamp'].toDate()),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('확인'),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
        if (hasNewAlarms)
          Positioned(
            right: 11,
            top: 11,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 14,
                minHeight: 14,
              ),
              child: Text(
                '!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}