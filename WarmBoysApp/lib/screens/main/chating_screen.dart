import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_end_drawer.dart';

class ChatingScreen extends StatefulWidget {
  @override
  _ChatingScreenState createState() => _ChatingScreenState();
}

class _ChatingScreenState extends State<ChatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '채팅',
        leading: null,
      ),
      body: Column(
        children: [],
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
