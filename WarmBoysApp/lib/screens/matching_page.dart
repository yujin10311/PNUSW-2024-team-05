import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_end_drawer.dart';
import '../widgets/sort_button.dart';
import '../delegates/matching_search_delegate.dart';

class MatchingPage extends StatefulWidget {
  @override
  _MatchingPageState createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  String _selectedSort = '날짜순';

  void _onSortChanged(String sortOption) {
    setState(() {
      _selectedSort = sortOption;
    });
    // 정렬 로직 추가 부분
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '매칭 페이지',
        leading: null,
        searchDelegate: MatchingSearchDelegate(),
      ),
      body: Column(
        children: [
          SortButton(onSortChanged: _onSortChanged),
          Expanded(
            child: Center(
              child: Text('매칭 페이지 내용'),
            ),
          ),
        ],
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
