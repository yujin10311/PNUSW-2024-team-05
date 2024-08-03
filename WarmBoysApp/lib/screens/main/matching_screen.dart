import 'package:flutter/material.dart';
import 'package:warm_boys/utils/firebase_helper.dart';
import '../../widgets/custom_app_bar_with_tab.dart';
import '../../widgets/custom_end_drawer.dart';
import 'package:provider/provider.dart';
import '../../providers/custom_auth_provider.dart';
import 'package:intl/intl.dart';

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
    return DateFormat('yy.M.d').format(dateTime);
  }

  void _buildSeniorInfoDialog(BuildContext context, Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '이름: ${post['username']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text('postId: ${post['postId']}'),
                SizedBox(height: 8),
                Text('위치: ${post['city']}'),
                SizedBox(height: 8),
                Text('평점: ${post['rating']} (${post['ratingCount']})'),
                SizedBox(height: 8),
                Text('돌봄 유형: ${post['dependentType']}'),
                SizedBox(height: 8),
                Text('반려동물 여부: ${post['withPet'] ? "있음" : "없음"}'),
                SizedBox(height: 8),
                Text('카메라 여부: ${post['withCam'] ? "있음" : "없음"}'),
                SizedBox(height: 8),
                Text('반려동물 정보: ${post['petInfo']}'),
                SizedBox(height: 8),
                Text('증상: ${post['symptom'].join(", ")}'),
                SizedBox(height: 8),
                Text('증상 정보: ${post['symptomInfo']}'),
                SizedBox(height: 8),
                Text('걷기 상태: ${post['walkingType']}'),
              ],
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
      return _buildSeniorScaffold();
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
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Card(
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
                                      Text(
                                        post['username'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                          '${post['rating']} (${post['ratingCount']})'),
                                      SizedBox(height: 4),
                                      Text(
                                          '장소:  ${post['city']} > ${post['gu']} > ${post['dong']}'),
                                      Text(
                                          '날짜:  ${formatDate(post['startTime'])}'),
                                      Text(
                                          "시간:  ${formatTime(post['startTime'])} ~ ${formatTime(post['endTime'])}"),
                                      Text('활동:  ${post['activityType']}'),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.person, size: 80),
                                      onPressed: () {
                                        _buildSeniorInfoDialog(context, post);
                                      },
                                    ),
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
                    );
                  },
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
  Scaffold _buildSeniorScaffold() {
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
          Center(child: Text('시니어 - 매칭 전 화면')),
          Center(child: Text('시니어 - 매칭 후 화면')),
        ],
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
