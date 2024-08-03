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
                                          Text(
                                              '${post['rating']} (${post['ratingCount']})',
                                              style: TextStyle(
                                                fontSize: 15,
                                              )),
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
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Icon(Icons.person, size: 80),
                                        SizedBox(height: 5),
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
          Center(child: Text('메이트 - 매칭 후 화면')),
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
                                          Text(
                                              '${post['rating']} (${post['ratingCount']})',
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
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
                                        Icon(Icons.person, size: 80),
                                        SizedBox(height: 5),
                                        ElevatedButton(
                                          onPressed: () async {
                                            // 페이지 새로 고침
                                            // setState(() {});
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
          Center(child: Text('시니어 - 매칭 후 화면')),
        ],
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
