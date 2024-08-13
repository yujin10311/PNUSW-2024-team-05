import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/custom_auth_provider.dart';
import '../screens/notification/notification_page.dart';

class CustomAlarmButton extends StatefulWidget {
  @override
  _CustomAlarmButtonState createState() => _CustomAlarmButtonState();
}

class _CustomAlarmButtonState extends State<CustomAlarmButton> {
  bool hasNewAlarms = false;

  @override
  void initState() {
    super.initState();
    _checkForAlarms();
  }

  Future<void> _checkForAlarms() async {
    final userId = Provider.of<CustomAuthProvider>(context, listen: false).uid;
    if (userId != null) {
      final alarmSnapshot = await FirebaseFirestore.instance
          .collection('alarms')
          .doc(userId)
          .get();
      if (alarmSnapshot.exists && alarmSnapshot.data()?['hasNewAlarms'] == true) {
        setState(() {
          hasNewAlarms = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationPage(),
              ),
            );
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