import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:warm_boys/utils/firebase_helper.dart';
import '../../widgets/custom_app_bar_with_tab.dart';
import '../../widgets/custom_end_drawer.dart';
import 'package:provider/provider.dart';
import '../../providers/custom_auth_provider.dart';
import 'package:intl/intl.dart';
import '../../widgets/exchange_card.dart';
import '../../widgets/member_details_scrollview.dart';
import '../../widgets/member_symptom_scrollview.dart';
import '../../widgets/autowrap_text_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExchangeScreen extends StatefulWidget {
  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

// 바텀모달로 터치시 추가정보 띄우기

class _ExchangeScreenState extends State<ExchangeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Provider.of<CustomAuthProvider>(this.context, listen: false);
  }

  int credit = 0;
  int isinit = 1;

  Future exchanging(
    BuildContext context,
    int howmuch,
    int userCredit,
    String uid,
  ) async {
    if (userCredit < howmuch) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'))
                ],
                title: Text('교환이 불가합니다.'),
                content: Text('사유 : 크레딧이 부족합니다.'),
              ));
    } else if (userCredit >= howmuch) {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(uid)
          .update({"credit": userCredit - howmuch});
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'))
                ],
                title: Text('신청되셨습니다.'),
                content: Text('남은 크레딧 : ${userCredit - howmuch}'),
              ));
      creditChange(howmuch);
    }
  }

  void creditChange(int howmuch) {
    setState(() {
      credit = credit - howmuch;
    });
    print(credit);
  }

  void _buildInfoDialog(
    BuildContext context,
    Map<String, dynamic> exchange,
    int userCredit,
    String uid,
  ) {
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
                  ExchangeCard(
                      imgUrl: exchange['imgUrl'],
                      goodsName: exchange['goodsName'],
                      inc: exchange['inc'],
                      maxHeadcounts: exchange['maxHeadcounts'],
                      needCredit: exchange['needCredit']),
                  FloatingActionButton(
                      onPressed: () {
                        exchanging(
                            context, exchange['needCredit'], userCredit, uid);
                      },
                      child: Text('교환')),
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
    if (isinit == 1) {
      setState(() {
        credit = userInfo?['credit'] ?? 0;
        isinit = 0;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('교환페이지'),
        leading: null,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('exchanges').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('존재하는 교환이 없습니다.'));
            } else {
              return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '내 리워드',
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
                            child: Text(credit.toString()),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (ctx, index) => GestureDetector(
                                onTap: () {
                                  _buildInfoDialog(
                                      context,
                                      snapshot.data!.docs[index].data()
                                          as Map<String, dynamic>,
                                      credit,
                                      myUid!);
                                },
                                child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        ExchangeCard(
                                          imgUrl: snapshot.data!.docs[index]
                                              ['imgUrl'],
                                          goodsName: snapshot.data!.docs[index]
                                              ['goodsName'],
                                          inc: snapshot.data!.docs[index]
                                              ['inc'],
                                          maxHeadcounts: snapshot.data!
                                              .docs[index]['maxHeadcounts'],
                                          needCredit: snapshot.data!.docs[index]
                                              ['needCredit'],
                                        ),
                                      ],
                                    )),
                              ))
                    ],
                  ));
            }
          }),

      // body: Column(
      //   children: [
      //     FutureBuilder<List<Map<String, dynamic>>>(
      //       future: FirebaseHelper.queryExchanges(myUid!),
      //       builder: (context, snapshot) {
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return Center(child: CircularProgressIndicator());
      //         } else if (snapshot.hasError) {
      //           return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
      //         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      //           return Center(child: Text('교환페이지가 없습니다.'));
      //         } else {
      //           final exchanges = snapshot.data!;
      //           return RefreshIndicator(
      //             onRefresh: () async {
      //               setState(() {});
      //             },
      //             child: ListView.builder(
      //               itemCount: exchanges.length,
      //               itemBuilder: (context, index) {
      //                 final exchange = exchanges[index];
      //                 return GestureDetector(
      //                   onTap: () {
      //                     _buildInfoDialog(context, exchange);
      //                   },
      //                   child: Card(
      //                     child: Padding(
      //                       padding: const EdgeInsets.all(15.0),
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Row(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Expanded(
      //                                 child: Column(
      //                                   crossAxisAlignment:
      //                                       CrossAxisAlignment.start,
      //                                   children: [
      //                                     Row(
      //                                       children: [
      //                                         Text(
      //                                           exchange['goodsName'],
      //                                           style: TextStyle(
      //                                             fontSize: 18,
      //                                             fontWeight: FontWeight.bold,
      //                                           ),
      //                                         ),
      //                                         SizedBox(width: 10),
      //                                         Text(
      //                                           exchange['inc'],
      //                                           style: TextStyle(
      //                                             fontSize: 16,
      //                                             color: const Color.fromARGB(
      //                                                 255, 110, 110, 110),
      //                                             // fontWeight: FontWeight.bold,
      //                                           ),
      //                                         ),
      //                                       ],
      //                                     ),
      //                                     SizedBox(height: 4),
      //                                     Text(
      //                                         '${exchange['maxHeadcounts']} (${exchange['needCredit']})',
      //                                         style: TextStyle(
      //                                           fontSize: 16,
      //                                         )),
      //                                     SizedBox(height: 4),
      //                                   ],
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 );
      //               },
      //             ),
      //           );
      //         }
      //       },
      //     ),
      //   ],
      // ),

      endDrawer: CustomEndDrawer(),
    );
  }
}
