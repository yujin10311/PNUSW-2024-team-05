import 'package:flutter/material.dart';
import 'package:warm_boys/widgets/custom_app_bar.dart';
import 'package:warm_boys/widgets/custom_end_drawer.dart';

class MatchingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '매칭 페이지'),
      body: Center(
        child: Text('매칭 페이지 내용'),
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
