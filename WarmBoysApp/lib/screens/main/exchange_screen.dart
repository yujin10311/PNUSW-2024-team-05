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
  late Future<List<Map<String, dynamic>>> _exchangePosts;

  @override
  void initState() {
    super.initState();
    _exchangePosts =
        FirebaseHelper.queryExchangePosts(); // queryExchangePosts 호출
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _exchangePosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('존재하는 교환이 없습니다.'));
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _exchangePosts = FirebaseHelper
                        .queryExchangePosts(); // 새로고침 시 queryExchangePosts 다시 호출
                  });
                },
                child: Column(
                  children: [
                    memberType == '메이트' ? SizedBox(height: 20) : Container(),
                    memberType == '메이트'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '내 크레딧',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
                                        color: Color.fromARGB(255, 224, 73, 81),
                                        width: 3)),
                                child: Text(myCredit.toString(),
                                    style: TextStyle(fontSize: 16)),
                              )
                            ],
                          )
                        : Container(),
                    memberType == '메이트'
                        ? SizedBox(
                            height: 20,
                          )
                        : Container(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data![index];
                          return GestureDetector(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Card(
                                color: Colors.white,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data['imgUrl']),
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
                                          style:
                                              TextStyle(color: Colors.black54)),
                                      Text(
                                        data['supportReason'],
                                        style: TextStyle(color: Colors.black54),
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
                                  builder: (context) => ExchangeInfoScreen(
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
              );
            }
          }),
      endDrawer: CustomEndDrawer(),
    );
  }
}
