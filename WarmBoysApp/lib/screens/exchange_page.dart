import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_end_drawer.dart';
import '../widgets/sort_button.dart';

class ExchangePage extends StatefulWidget {
  @override
  _ExchangePageState createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  String _selectedSort = '날짜순';

  void _onSortChanged(String sortOption) {
    setState(() {
      _selectedSort = sortOption;
    });
    // 정렬 로직을 여기에 추가하세요.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '교환 페이지'),
      body: Column(
        children: [
          SortButton(onSortChanged: _onSortChanged),
          Expanded(
            child: Center(
              child: Text('교환 페이지 내용'),
            ),
          ),
        ],
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
