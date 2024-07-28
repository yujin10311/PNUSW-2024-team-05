import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_end_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '홈페이지',
        leading: null, // '뒤로 가기 버튼' 제거
      ),
      body: Column(
        children: [],
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
