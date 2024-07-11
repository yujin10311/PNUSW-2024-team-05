import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_end_drawer.dart';

class ExchangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '매칭 페이지'),
      body: Center(
        child: Text('교환 페이지 내용'),
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
