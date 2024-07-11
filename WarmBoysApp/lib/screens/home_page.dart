import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_end_drawer.dart';
import '../widgets/image_card.dart';
import '../widgets/sort_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      appBar: CustomAppBar(title: '홈페이지'),
      body: Column(
        children: [
          SortButton(onSortChanged: _onSortChanged),
          // 이미지 카드 목록
          Expanded(
            child: ListView(
              children: [
                ImageCard(
                  imagePath: 'assets/icons/profile_blank.png',
                  title: '제목 1',
                  date: '2024-07-10',
                  time: '12:00 PM',
                  description: '간단한 설명 1',
                ),
                ImageCard(
                  imagePath: 'assets/icons/profile_blank.png',
                  title: '제목 2',
                  date: '2024-07-11',
                  time: '01:00 PM',
                  description: '간단한 설명 2',
                ),
                ImageCard(
                  imagePath: 'assets/icons/profile_blank.png',
                  title: '제목 3',
                  date: '2024-07-12',
                  time: '02:00 PM',
                  description: '간단한 설명 3',
                ),
                ImageCard(
                  imagePath: 'assets/icons/profile_blank.png',
                  title: '제목 3',
                  date: '2024-07-12',
                  time: '02:00 PM',
                  description: '간단한 설명 3',
                ),
                ImageCard(
                  imagePath: 'assets/icons/profile_blank.png',
                  title: '제목 3',
                  date: '2024-07-12',
                  time: '02:00 PM',
                  description: '간단한 설명 3',
                ),
                // 원하는 만큼 이미지 카드 추가
              ],
            ),
          ),
        ],
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
