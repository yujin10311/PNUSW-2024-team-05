import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    _fetchPostcards(); // 기본 설정된 DateTimeRange를 기반으로 _fetchPostcards 호출
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
    final memberType = userInfo?['memberType'];

    return Scaffold(
      appBar: CustomAppBar(
        title: '홈페이지',
        leading: null, // '뒤로 가기 버튼' 제거
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (memberType == '시니어')
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () {
                        // 앱 사용자 정보
                        String myUid = uid ?? '';
                        String memberType = userInfo?['memberType'] ?? '';
                        // 공고 작성자 정보
                        String seniorUid = uid ?? '';
                        String seniorName = userInfo?['username'] ?? '';
                        double rating = userInfo?['rating'] ?? 0.0;
                        int ratingCount = userInfo?['ratingCount'] ?? 0;
                        String dependentType = userInfo?['dependentType'] ?? '';
                        bool withPet = userInfo?['withPet'] ?? false;
                        bool withCam = userInfo?['withCam'] ?? false;
                        List<String> symptom =
                            List<String>.from(userInfo?['symptom'] ?? []);
                        String walkingType = userInfo?['walkingType'] ?? '';
                        String petInfo = userInfo?['petInfo'] ?? '';
                        String symptomInfo = userInfo?['symptomInfo'] ?? '';
                        // 공고 정보
                        String postId = '';
                        String city = userInfo?['city'] ?? '';
                        String gu = userInfo?['gu'] ?? '';
                        String dong = userInfo?['dong'] ?? '';
                        String status = '';
                        String activityType = '';
                        DateTime startTime = DateTime.now();
                        DateTime endTime = DateTime.now();

                        // PostScreen으로 라우트
                        Navigator.pushNamed(context, '/post_screen',
                            arguments: {
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
                              'withCam': withCam,
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

                        // + 내 공고 작성하기 버튼 클릭 시의 동작을 여기에 추가
                      },
                      child: Text(
                        '+ 내 공고 작성하기',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                  items: <String>[
                    '구서1동',
                    '구서2동',
                    '금사회동동',
                    '금성동',
                    '남산동',
                    '부곡1동',
                    '부곡2동',
                    '부곡3동',
                    '부곡4동',
                    '서1동',
                    '서2동',
                    '서3동',
                    '선두구동',
                    '장전1동',
                    '장전2동',
                    '청룡노포동',
                  ].map<DropdownMenuItem<String>>((String value) {
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
                      bool withCam = postcard['withCam'];
                      List<String> symptom =
                          List<String>.from(postcard['symptom']);
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
                        'withCam': withCam,
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
