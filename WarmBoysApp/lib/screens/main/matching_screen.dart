import 'package:flutter/material.dart';
import 'package:warm_boys/utils/firebase_helper.dart';
import '../../widgets/custom_app_bar_with_tab.dart';
import '../../widgets/custom_end_drawer.dart';
import 'package:provider/provider.dart';
import '../../providers/custom_auth_provider.dart';
import 'package:intl/intl.dart';
import '../../widgets/profile_card.dart';
import '../../widgets/member_details_scrollview.dart';
import '../../widgets/member_symptom_scrollview.dart';
import '../../widgets/autowrap_text_box.dart';
import '../activity/activity_screen.dart';
import '../../widgets/rating_stars.dart';
import '../../widgets/rate_stars.dart';
import '../review/rating_by_senior.dart';

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
    Provider.of<CustomAuthProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String formatTime(DateTime dateTime) {
    return DateFormat('a h시')
        .format(dateTime)
        .replaceAll('AM', '오전')
        .replaceAll('PM', '오후');
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('yy.MM.dd').format(dateTime);
  }

// 메이트 정보 다이얼로그(시니어 시점)
  void _buildMateInfoDialog(BuildContext context, Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(),
          ),
          body: Container(
            padding: EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('닫기', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 2),
                        Icon(Icons.close),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  ProfileCard(
                      imgUrl: post['imgUrl'],
                      username: post['username'],
                      uid: post['uid'],
                      city: post['city'],
                      gu: post['gu'],
                      dong: post['dong'],
                      rating: post['rating'],
                      ratingCount: post['ratingCount']),
                  SizedBox(height: 30),
                  Text(
                    '이름',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  MemberSymptomScrollview(symptoms: [post['username']]),
                  // AutowrapTextBox(text: post['username']),
                  SizedBox(height: 30),
                  Text(
                    '나이',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  MemberSymptomScrollview(symptoms: [post['age']]),
                  // AutowrapTextBox(text: post['age']),
                  SizedBox(height: 30),
                  Text(
                    '성별',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  MemberSymptomScrollview(symptoms: [post['gender']]),
                  // AutowrapTextBox(text: post['gender']),
                  SizedBox(height: 30),
                  Text(
                    '추가 정보',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  AutowrapTextBox(text: post['addInfo']),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// 시니어 정보 다이얼로그(메이트 시점)
  void _buildSeniorInfoDialog(BuildContext context, Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(),
          ),
          body: Container(
            padding: EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('닫기', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 2),
                        Icon(Icons.close),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  ProfileCard(
                      imgUrl: post['imgUrl'],
                      username: post['username'],
                      uid: post['uid'],
                      city: post['city'],
                      gu: post['gu'],
                      dong: post['dong'],
                      rating: post['rating'],
                      ratingCount: post['ratingCount']),
                  SizedBox(height: 30),
                  Text(
                    '회원 상세 정보',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  MemberDetailsScrollview(
                      dependentType: post['dependentType'],
                      withPet: post['withPet'],
                      withCam: post['withCam']),
                  SizedBox(height: 30),
                  Text(
                    '반려동물 상세 설명',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  AutowrapTextBox(text: post['petInfo']),
                  SizedBox(height: 30),
                  Text(
                    '해당되는 증상',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  MemberSymptomScrollview(symptoms: post['symptom']),
                  SizedBox(height: 30),
                  Text(
                    '증상 상세 설명',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  AutowrapTextBox(text: post['symptomInfo']),
                  SizedBox(height: 30),
                  Text(
                    '거동 상태',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  MemberSymptomScrollview(symptoms: [post['walkingType']]),
                  SizedBox(height: 30),
                  Text(
                    '추가 정보',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  AutowrapTextBox(text: post['addInfo']),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final customAuthProvider = Provider.of<CustomAuthProvider>(context);
    final userInfo = customAuthProvider.userInfo;
    final myUid = customAuthProvider.uid;
    final memberType = userInfo?['memberType'];

    if (memberType == '메이트') {
      return _buildMateScaffold(myUid!);
    } else if (memberType == '시니어') {
      return _buildSeniorScaffold(myUid!);
    } else {
      return Scaffold(
        appBar: CustomAppBarWithTab(
          title: '매칭 페이지',
        ),
        body: Center(child: Text('알 수 없는 회원 타입입니다.')),
        endDrawer: CustomEndDrawer(),
      );
    }
  }

  // 메이트가 보는 화면
  Scaffold _buildMateScaffold(String myUid) {
    return Scaffold(
      appBar: CustomAppBarWithTab(
        title: '매칭 페이지 - 메이트',
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
          // 매칭 전 화면(메이트)
          FutureBuilder<List<Map<String, dynamic>>>(
            future: FirebaseHelper.queryNotMatchedByMate(myUid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('매칭 전 공고가 없습니다.'));
              } else {
                final posts = snapshot.data!;
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return GestureDetector(
                        onTap: () {
                          _buildSeniorInfoDialog(context, post);
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                post['username'],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                post['applyTimeText'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: const Color.fromARGB(
                                                      255, 110, 110, 110),
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              RatingStars(
                                                  rating: post['rating']),
                                              Text(
                                                "${post['rating'].toStringAsFixed(2)} (${post['ratingCount']})",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                              '장소:  ${post['city']} > ${post['gu']} > ${post['dong']}',
                                              style: TextStyle(
                                                fontSize: 13,
                                              )),
                                          Text(
                                              '날짜:  ${formatDate(post['startTime'])}',
                                              style: TextStyle(
                                                fontSize: 13,
                                              )),
                                          Text(
                                              '시간:  ${formatTime(post['startTime'])} ~ ${formatTime(post['endTime'])}',
                                              style: TextStyle(
                                                fontSize: 13,
                                              )),
                                          Text('활동:  ${post['activityType']}',
                                              style: TextStyle(
                                                fontSize: 13,
                                              )),
                                          SizedBox(height: 5),
                                          Text(
                                            '크레딧: ${post['credit'].toString()}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        (post['imgUrl'] != '')
                                            ? GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Dialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // 클릭 시 다이얼로그 닫기
                                                          },
                                                          child: Center(
                                                            child: Image
                                                                .network(post[
                                                                    'imgUrl']), // 확대된 이미지
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: NetworkImage(
                                                      post['imgUrl']),
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 50,
                                                child: Icon(Icons.person),
                                              ),
                                        SizedBox(height: 10),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await FirebaseHelper.cancelApply(
                                                post['postId'], myUid);
                                            // 페이지 새로 고침
                                            setState(() {});
                                          },
                                          child: Text('신청 취소',
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
          // 매칭 후 화면(메이트)
          FutureBuilder<List<Map<String, dynamic>>>(
            future: FirebaseHelper.queryMatchedByMate(myUid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('매칭 후 공고가 없습니다.'));
              } else {
                final posts = snapshot.data!;
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return GestureDetector(
                        onTap: () {
                          _buildSeniorInfoDialog(context, post);
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                post['username'],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                post['acceptTimeText'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: const Color.fromARGB(
                                                      255, 110, 110, 110),
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              RatingStars(
                                                  rating: post['rating']),
                                              Text(
                                                "${post['rating'].toStringAsFixed(2)} (${post['ratingCount']})",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                              '장소:  ${post['city']} > ${post['gu']} > ${post['dong']}',
                                              style: TextStyle(
                                                fontSize: 13,
                                              )),
                                          Text(
                                              '날짜:  ${formatDate(post['startTime'])}',
                                              style: TextStyle(
                                                fontSize: 13,
                                              )),
                                          Text(
                                              '시간:  ${formatTime(post['startTime'])} ~ ${formatTime(post['endTime'])}',
                                              style: TextStyle(
                                                fontSize: 13,
                                              )),
                                          Text('활동:  ${post['activityType']}',
                                              style: TextStyle(
                                                fontSize: 13,
                                              )),
                                          SizedBox(height: 5),
                                          Text(
                                            '크레딧: ${post['credit'].toString()}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        (post['imgUrl'] != '')
                                            ? GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Dialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // 클릭 시 다이얼로그 닫기
                                                          },
                                                          child: Center(
                                                            child: Image
                                                                .network(post[
                                                                    'imgUrl']), // 확대된 이미지
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: NetworkImage(
                                                      post['imgUrl']),
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 50,
                                                child: Icon(Icons.person),
                                              ),
                                        SizedBox(height: 10),
                                        ElevatedButton(
                                          onPressed: post['status'] == 'matched'
                                              ? () {
                                                  // print(post['postId']);
                                                  // print(post['status']);
                                                  // print(post['uid']);
                                                  // print(post['phoneNum2']);
                                                  // print(myUid);
                                                  // '활동 시작' 버튼을 눌렀을 때의 동작
                                                  Navigator.pushNamed(context,
                                                      '/activity_screen',
                                                      arguments: {
                                                        'postId':
                                                            post['postId'],
                                                        'currentStatus':
                                                            post['status'],
                                                        'seniorUid':
                                                            post['uid'],
                                                        'seniorPhoneNum2':
                                                            post['phoneNum2'],
                                                        'mateUid': myUid,
                                                      });
                                                }
                                              : post['status'] == 'activated'
                                                  ? () {
                                                      // '활동 중' 버튼을 눌렀을 때의 동작
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/activity_screen',
                                                          arguments: {
                                                            'postId':
                                                                post['postId'],
                                                            'currentStatus':
                                                                post['status'],
                                                            'seniorUid':
                                                                post['uid'],
                                                            'seniorPhoneNum2':
                                                                post[
                                                                    'phoneNum2'],
                                                            'mateUid': myUid,
                                                          });
                                                    }
                                                  : null, // 기타 상태일 때는 비활성화
                                          child: Text(
                                            post['status'] == 'matched'
                                                ? '활동 시작'
                                                : post['status'] == 'activated'
                                                    ? '활동 중'
                                                    : '활동 실패', // status가 'failed'일 때는 '활동 실패' 표시
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: post['status'] ==
                                                    'matched'
                                                ? Color.fromARGB(
                                                    255, 111, 255, 95)
                                                : post['status'] == 'activated'
                                                    ? const Color.fromARGB(
                                                        255, 255, 190, 92)
                                                    : Colors.grey,
                                            foregroundColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
      endDrawer: CustomEndDrawer(),
    );
  }

  // 시니어가 보는 화면
  Scaffold _buildSeniorScaffold(String myUid) {
    return Scaffold(
      appBar: CustomAppBarWithTab(
        title: '매칭 페이지 - 시니어',
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
          // 매칭 전 화면(시니어)
          FutureBuilder<List<Map<String, dynamic>>>(
            future: FirebaseHelper.queryNotMatchedBySenior(myUid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('매칭 전 공고가 없습니다.'));
              } else {
                final posts = snapshot.data!;
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return GestureDetector(
                        onTap: () {
                          _buildMateInfoDialog(context, post);
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                post['username'],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                post['applyTimeText'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: const Color.fromARGB(
                                                      255, 110, 110, 110),
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              RatingStars(
                                                  rating: post['rating']),
                                              Text(
                                                "${post['rating'].toStringAsFixed(2)} (${post['ratingCount']})",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                              '날짜:  ${formatDate(post['startTime'])}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                          Text(
                                              "시간:  ${formatTime(post['startTime'])} ~ ${formatTime(post['endTime'])}",
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                          Text('활동:  ${post['activityType']}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        (post['imgUrl'] != '')
                                            ? GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Dialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // 클릭 시 다이얼로그 닫기
                                                          },
                                                          child: Center(
                                                            child: Image
                                                                .network(post[
                                                                    'imgUrl']), // 확대된 이미지
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage: NetworkImage(
                                                      post['imgUrl']),
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 40,
                                                child: Icon(Icons.person),
                                              ),
                                        SizedBox(height: 5),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await FirebaseHelper.acceptMatching(
                                                post['uid'], post['postId']);
                                            // 페이지 새로 고침
                                            setState(() {});
                                          },
                                          child: Text('매칭 수락',
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),

          // 매칭 후 화면(시니어)
          FutureBuilder<List<Map<String, dynamic>>>(
            future: FirebaseHelper.queryMatchedBySenior(myUid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('매칭 후 공고가 없습니다.'));
              } else {
                final posts = snapshot.data!;
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return GestureDetector(
                        onTap: () {
                          _buildMateInfoDialog(context, post);
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                post['username'],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                post['acceptTimeText'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: const Color.fromARGB(
                                                      255, 110, 110, 110),
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              RatingStars(
                                                  rating: post['rating']),
                                              Text(
                                                "${post['rating'].toStringAsFixed(2)} (${post['ratingCount']})",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                              '날짜:  ${formatDate(post['startTime'])}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                          Text(
                                              "시간:  ${formatTime(post['startTime'])} ~ ${formatTime(post['endTime'])}",
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                          Text('활동:  ${post['activityType']}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        (post['imgUrl'] != '')
                                            ? GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Dialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // 클릭 시 다이얼로그 닫기
                                                          },
                                                          child: Center(
                                                            child: Image
                                                                .network(post[
                                                                    'imgUrl']), // 확대된 이미지
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage: NetworkImage(
                                                      post['imgUrl']),
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 40,
                                                child: Icon(Icons.person),
                                              ),
                                        SizedBox(height: 5),
                                        ElevatedButton(
                                          onPressed: post['status'] ==
                                                  'notReviewedBySenior'
                                              ? () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          RatingBySeniorPage(
                                                        postId: post['postId'],
                                                      ),
                                                    ),
                                                  );
                                                }
                                              : null,
                                          child: Text(
                                            post['status'] == 'matched'
                                                ? '활동 전'
                                                : post['status'] == 'activated'
                                                    ? '활동 중'
                                                    : post['status'] ==
                                                            'notReviewedBySenior'
                                                        ? '리뷰 쓰기'
                                                        : '활동 에러', // status가 notReviewedBySenior일 때
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: post['status'] ==
                                                    'notReviewedBySenior'
                                                ? const Color.fromARGB(
                                                    255, 255, 190, 92)
                                                : Color.fromARGB(
                                                    255, 129, 129, 129),
                                            foregroundColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
