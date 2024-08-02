import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // cloud_firestore 패키지 임포트 추가
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
  DateTimeRange _selectedDateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(Duration(days: 7)));
  String _selectedSort = "오름차순";
  String _selectedDong = "부곡1동";
  List<Map<String, dynamic>> _postcards = [];

  @override
  void initState() {
    super.initState();
    final customAuthProvider =
        Provider.of<CustomAuthProvider>(context, listen: false);
    final userInfo = customAuthProvider.userInfo;
    if (userInfo != null && userInfo['dong'] != null) {
      _selectedDong = userInfo['dong'];
    }
    _fetchPostcards();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        initialDateRange: _selectedDateRange);

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
        await FirebaseHelper.queryPostcardsByDurLocStat(
      _selectedDateRange.start,
      _selectedDateRange.end,
      _selectedDong,
      _selectedSort,
      'posted',
    );

    setState(() {
      _postcards = fetchedPostcards;
    });
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
                  child: Text('기간 선택'),
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
                      postcard['seniorName'],
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
                          "${formatDate(postcard['startTime'])} / ${formatTime(postcard['startTime'])} ~ ${formatTime(postcard['endTime'])}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    onTap: () {
                      // 앱 사용자 정보
                      String myUid = uid ?? '';
                      String memberType = userInfo?['memberType'] ?? '';
                      // 공고 작성자 정보
                      String seniorUid = postcard['seniorUid'];
                      String seniorName = postcard['seniorName'];
                      double rating = postcard['rating'];
                      int ratingCount = postcard['ratingCount'];
                      String dependentType = postcard['dependentType'];
                      bool withPet = postcard['withPet'];
                      List<String> symptom = postcard['symptom'];
                      String walkingType = postcard['walkingType'];
                      String petInfo = postcard['petInfo'] ?? '';
                      String symptomInfo = postcard['symptomInfo'];
                      // 공고 정보
                      String postId = postcard['postId'];
                      String city = postcard['city'];
                      String gu = postcard['gu'];
                      String dong = postcard['dong'];
                      String status = postcard['status'];
                      String activityType = postcard['activityType'];
                      DateTime startTime = postcard['startTime'];
                      DateTime endTime = postcard['endTime'];

                      // PostScreen으로 라우트
                      Navigator.pushNamed(context, '/post_screen', arguments: {
                        'memberType': memberType,
                        'postId': postId,
                        'myUid': myUid,
                        'seniorUid': seniorUid,
                        'seniorName': seniorName,
                        'city': city,
                        'gu': gu,
                        'dong': dong,
                        'dependentType': dependentType,
                        'withPet': withPet,
                        'withCam': postcard['withCam'],
                        'symptom': symptom,
                        'petInfo': petInfo,
                        'symptomInfo': symptomInfo,
                        'walkingType': walkingType,
                        'rating': rating,
                        'ratingCount': ratingCount,
                        'activityType': activityType,
                        'startTime': startTime,
                        'endTime': endTime,
                      });
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
