import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar_with_tab.dart'; // 위젯 경로를 맞춰주세요
import '../../widgets/custom_end_drawer.dart';

class MatchingScreen extends StatefulWidget {
  @override
  _MatchingScreenState createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithTab(
        title: '매칭 페이지',
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '매칭 전'),
            Tab(text: '매칭 후'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('매칭 전 화면')),
          Center(child: Text('매칭 후 화면')),
        ],
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
