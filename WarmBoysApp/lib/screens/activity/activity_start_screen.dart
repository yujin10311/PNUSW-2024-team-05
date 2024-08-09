import 'package:flutter/material.dart';

class ActivityStartScreen extends StatefulWidget {
  @override
  State<ActivityStartScreen> createState() => _ActivityStartScreenState();
}

class _ActivityStartScreenState extends State<ActivityStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("활동 시작 보고서 화면"),
      ),
    );
  }
}
