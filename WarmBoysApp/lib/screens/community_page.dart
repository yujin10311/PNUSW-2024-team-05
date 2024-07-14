import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_end_drawer.dart';
import '../widgets/sort_button.dart';
import '../delegates/community_search_delegate.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
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
      appBar: CustomAppBar(
        title: '커뮤니티',
        leading: null,
        searchDelegate: CommunitySearchDelegate(),
      ),
      body: Column(
        children: [
          SortButton(onSortChanged: _onSortChanged),
          Expanded(
            child: Center(
              child: Text('커뮤니티 내용'),
            ),
          ),
        ],
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
