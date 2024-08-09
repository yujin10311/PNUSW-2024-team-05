import 'package:flutter/material.dart';

class ActivityEndScreen extends StatefulWidget {
  @override
  State<ActivityEndScreen> createState() => _ActivityEndScreenState();
}

class _ActivityEndScreenState extends State<ActivityEndScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("활동 종료 보고서 화면"),
      ),
    );
  }
}
