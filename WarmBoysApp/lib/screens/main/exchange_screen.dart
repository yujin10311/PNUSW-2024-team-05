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
      appBar: CustomAppBar(title: "교환 페이지"),
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
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '내 크레딧',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 100,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(
                                  color: Colors.pink[100]!, width: 3)),
                          child: Text(myCredit.toString()),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data![index];
                          return GestureDetector(
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(data['imgUrl']),
                                  radius: 30,
                                ),
                                title: Text(
                                  data['goodsName'],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['inc'],
                                    ),
                                    Text(
                                      data['supportReason'],
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
