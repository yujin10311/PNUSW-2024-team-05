import 'package:flutter/material.dart';
import '../../utils/firebase_helper.dart'; // FirebaseHelper import

class ReviewScreen extends StatelessWidget {
  final String username;
  final String uid;
  final String memberType;

  ReviewScreen({
    required this.username,
    required this.uid,
    required this.memberType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$username 리뷰 목록'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: FirebaseHelper.queryReview(uid, memberType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('리뷰가 없습니다.'));
          } else {
            final reviews = snapshot.data!;
            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '활동 유형: ${review['activityType']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        if (memberType == '메이트') ...[
                          Text('시니어의 평점: ${review['ratingBySenior']}'),
                          SizedBox(height: 4),
                          Text('시니어의 리뷰: ${review['reviewBySenior']}'),
                        ] else if (memberType == '시니어') ...[
                          Text('메이트의 평점: ${review['ratingByMate']}'),
                          SizedBox(height: 4),
                          Text('메이트의 리뷰: ${review['reviewByMate']}'),
                        ],
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
