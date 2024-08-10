import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  final String postId;
  final String currentStatus;
  final String seniorUid;
  final String seniorPhoneNum2;
  final String mateUid;

  ActivityScreen({
    required this.postId,
    required this.currentStatus,
    required this.seniorUid,
    required this.seniorPhoneNum2,
    required this.mateUid,
  });

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.currentStatus == 'matched') {
      return _buildMatchedScaffold(widget.postId, widget.seniorUid,
          widget.seniorPhoneNum2, widget.mateUid);
    } else if (widget.currentStatus == 'activated') {
      return _buildActivatedScaffold(widget.postId, widget.seniorUid,
          widget.seniorPhoneNum2, widget.mateUid);
    } else {
      return Scaffold(
        appBar: AppBar(title: Text("그 외")),
      );
    }
  }
}

_buildMatchedScaffold(
    String postId, String seniorUid, String seniorPhoneNum2, String mateUid) {
  return Scaffold(
    appBar: AppBar(
      title: Text("CurrentStatus: Matched"),
    ),
  );
}

_buildActivatedScaffold(
    String postId, String seniorUid, String seniorPhoneNum2, String mateUid) {
  return Scaffold(
    appBar: AppBar(
      title: Text("CurrentStatus: Activated"),
    ),
  );
}
