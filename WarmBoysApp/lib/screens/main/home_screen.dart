import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // cloud_firestore 패키지 임포트 추가
import 'package:provider/provider.dart';
import '../../providers/custom_auth_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_end_drawer.dart';
import '../../utils/firebase_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTimeRange? _selectedDateRange;
  String _selectedSort = "오름차순";
  String _selectedDong = "부곡1동";
  List<Map<String, dynamic>> _postcards = [];

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: _selectedDateRange ??
          DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(Duration(days: 7)),
          ),
    );

    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
        _fetchPostcards();
      });
    }
  }

  Future<void> _fetchPostcards() async {
    if (_selectedDateRange == null) return;

    List<Map<String, dynamic>> fetchedPostcards =
        await FirebaseHelper.queryPostcardsByDurAndLoc(
      _selectedDateRange!.start,
      _selectedDateRange!.end,
      _selectedDong,
      _selectedSort,
    );

    setState(() {
      _postcards = fetchedPostcards;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPostcards();
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy.MM.dd').format(date);
  }

  String formatTime(DateTime dateTime) {
    return DateFormat('a h시')
        .format(dateTime)
        .replaceAll('AM', '오전')
        .replaceAll('PM', '오후');
  }

  @override
  Widget build(BuildContext context) {
    final customAuthProvider = Provider.of<CustomAuthProvider>(context);
    final userInfo = customAuthProvider.userInfo;
    final uid = customAuthProvider.uid;

    return Scaffold(
      appBar: CustomAppBar(
        title: '홈페이지',
        leading: null, // '뒤로 가기 버튼' 제거
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _selectDateRange(context),
                  child: Text('날짜 범위 선택'),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedSort,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSort = newValue!;
                      _fetchPostcards();
                    });
                  },
                  items: <String>['오름차순', '내림차순']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedDong,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDong = newValue!;
                      _fetchPostcards();
                    });
                  },
                  items: <String>['부곡1동', '남산동', '서2동']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _postcards.length,
              itemBuilder: (context, index) {
                final postcard = _postcards[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person, size: 30),
                    ),
                    title: Text(
                      postcard['username'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${postcard['city']} > ${postcard['gu']} > ${postcard['dong']}",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "${postcard['rating'].toStringAsFixed(2)} (${postcard['ratingCount']})",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "${formatDate((postcard['startTime'] as Timestamp).toDate())} / ${formatTime((postcard['startTime'] as Timestamp).toDate())} ~ ${formatTime((postcard['endTime'] as Timestamp).toDate())}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    onTap: () {
                      String seniorUid = postcard['seniorUid'];
                      String myUid = uid ?? '';
                      String memberType = userInfo?['memberType'] ?? '';
                      String postId = postcard['postId'];

                      print("myUid: ${myUid}\nseniorUid: ${seniorUid}");

                      if (seniorUid == myUid) {
                        Navigator.pushNamed(context, '/post_senior_my_screen',
                            arguments: postId);
                      } else if (memberType == '시니어') {
                        Navigator.pushNamed(context, '/post_senior_screen',
                            arguments: {
                              'postId': postId,
                              'seniorUid': seniorUid
                            });
                      } else if (memberType == '메이트') {
                        Navigator.pushNamed(context, '/post_mate_screen',
                            arguments: {
                              'postId': postId,
                              'seniorUid': seniorUid
                            });
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
