import 'package:flutter/material.dart';
import 'package:warm_boys/widgets/custom_app_bar.dart';
import '../../widgets/custom_end_drawer.dart';
import 'package:provider/provider.dart';
import '../../providers/custom_auth_provider.dart';
import '../../utils/firebase_helper.dart';
import '../post/exchange_info_screen.dart';

class ExchangeScreen extends StatefulWidget {
  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen>
    with SingleTickerProviderStateMixin {
  late Future<Map<String, List<Map<String, dynamic>>>> _exchangePosts;
  Future<List<Map<String, dynamic>>>? _exchange_0;
  Future<List<Map<String, dynamic>>>? _exchange_1;

  @override
  void initState() {
    super.initState();
    _exchangePosts = FirebaseHelper.queryExchangePosts();
    _initializeExchanges();
  }

  void _initializeExchanges() async {
    final posts = await _exchangePosts;
    setState(() {
      _exchange_0 = Future.value(posts['기관장학금'] ?? []);
      _exchange_1 = Future.value(posts['기업상품'] ?? []);
    });
  }

  @override
  Widget build(BuildContext context) {
    final customAuthProvider = Provider.of<CustomAuthProvider>(context);
    final userInfo = customAuthProvider.userInfo;
    final uid = customAuthProvider.uid!;
    final myCredit = userInfo!['credit'] ?? 0;
    final memberType = userInfo['memberType'];

    return Scaffold(
      appBar: CustomAppBar(title: "교환"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '내 크레딧',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 100,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                          color: Color.fromARGB(255, 224, 73, 81), width: 3)),
                  child:
                      Text(myCredit.toString(), style: TextStyle(fontSize: 16)),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("복지 재단 장학금",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 3),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _exchange_0,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('존재하는 교환이 없습니다.'));
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        setState(
                          () {
                            _exchangePosts = FirebaseHelper
                                .queryExchangePosts(); // 새로고침 시 queryExchangePosts 다시 호출
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data![index];
                                return GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0, vertical: 8.0),
                                    child: SizedBox(
                                      width: 360, // 카드의 너비를 설정
                                      child: Card(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 5),
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    data['imgUrl'] as String),
                                                radius: 45,
                                              ),
                                              SizedBox(width: 16.0),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      data['goodsName']
                                                          as String,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'NotoSansKR',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.0),
                                                    Text(
                                                      data['inc'] as String,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'NotoSansKR',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                    SizedBox(height: 4.0),
                                                    Text(
                                                      '${data['needCredit']} 크레딧  (${data['currentHeadcounts']} / ${data['maxHeadcounts']})',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'NotoSansKR',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Colors.black54),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ExchangeInfoScreen(
                                                uid: uid,
                                                myCredit: myCredit,
                                                memberType: memberType,
                                                post: data),
                                      ),
                                    )
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("협력 기업 상품",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 10),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _exchange_1,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('존재하는 교환이 없습니다.'));
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        setState(
                          () {
                            _exchangePosts = FirebaseHelper
                                .queryExchangePosts(); // 새로고침 시 queryExchangePosts 다시 호출
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data![index];
                                return GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Card(
                                      color: Colors.white,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(data['goodsImgUrl']),
                                          radius: 30,
                                        ),
                                        title: Text(
                                          data['goodsName'],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(data['inc'],
                                                style: TextStyle(
                                                    color: Colors.black54)),
                                            Text(
                                              data['supportReason'],
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        trailing: Column(
                                          children: [
                                            Text(
                                              '${data['needCredit']} 크레딧',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              '(${data['currentHeadcounts']} / ${data['maxHeadcounts']})',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ExchangeInfoScreen(
                                                uid: uid,
                                                myCredit: myCredit,
                                                memberType: memberType,
                                                post: data),
                                      ),
                                    )
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
