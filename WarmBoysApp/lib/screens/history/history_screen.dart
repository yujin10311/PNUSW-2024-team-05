import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/firebase_helper.dart';
import '../../providers/custom_auth_provider.dart';
import '../../screens/history/history_detailed_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<Map<String, dynamic>>> _activitiesFuture;

  @override
  void initState() {
    super.initState();
    final customAuthProvider =
        Provider.of<CustomAuthProvider>(context, listen: false);
    final _uid = customAuthProvider.uid;
    final _memberType = customAuthProvider.userInfo!['memberType'];
    _activitiesFuture = FirebaseHelper.queryActivities(_uid!, _memberType);
  }

  @override
  Widget build(BuildContext context) {
    final customAuthProvider =
        Provider.of<CustomAuthProvider>(context, listen: false);
    final _memberType = customAuthProvider.userInfo!['memberType'];
    final _credit = customAuthProvider.userInfo!['credit'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "활동 기록",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
        child: Column(
          children: [
            _memberType == '메이트'
                ? Column(
                    children: [
                      Divider(
                        color: Colors.grey[200],
                        thickness: 2,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "내 크레딧:",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(width: 15),
                          Text('$_credit',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: Colors.grey[200],
                        thickness: 2,
                      ),
                    ],
                  )
                : Container(),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _activitiesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('에러가 발생했습니다.'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('활동 기록이 없습니다.'));
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: snapshot.data!.map((activity) {
                          return GestureDetector(
                            child: Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 20, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          (activity['imgUrl'] != '')
                                              ? GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Dialog(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // 클릭 시 다이얼로그 닫기
                                                            },
                                                            child: CircleAvatar(
                                                              radius: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.5,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      activity[
                                                                          'imgUrl']), // 확대된 이미지
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 40,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            activity['imgUrl']),
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  radius: 40,
                                                  child: Icon(Icons.person),
                                                ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            activity['username'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "장소: ${activity['activityCity']} ${activity['activityGu']} ${activity['activityDong']}",
                                            style: TextStyle(
                                                fontSize: _memberType == '메이트'
                                                    ? 14
                                                    : 16),
                                          ),
                                          Text(
                                            "날짜: ${activity['date']}",
                                            style: TextStyle(
                                                fontSize: _memberType == '메이트'
                                                    ? 14
                                                    : 16),
                                          ),
                                          Text(
                                            "시간: ${activity['startTime']} ~ ${activity['endTime']}",
                                            style: TextStyle(
                                                fontSize: _memberType == '메이트'
                                                    ? 14
                                                    : 16),
                                          ),
                                          Text(
                                            "활동 종류: ${activity['activityType']}",
                                            style: TextStyle(
                                                fontSize: _memberType == '메이트'
                                                    ? 14
                                                    : 16),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "크레딧: ${activity['credit']}",
                                            style: TextStyle(
                                              fontSize: _memberType == '메이트'
                                                  ? 14
                                                  : 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HistoryDetailedScreen(
                                      memberType: _memberType,
                                      activity: activity),
                                ),
                              )
                            },
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
