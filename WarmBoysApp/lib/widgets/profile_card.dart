import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String imgUrl;
  final String username;
  final String uid;
  final String city;
  final String gu;
  final String dong;
  final double rating;
  final int ratingCount;

  ProfileCard({
    required this.imgUrl,
    required this.username,
    required this.uid,
    required this.city,
    required this.gu,
    required this.dong,
    required this.rating,
    required this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            (imgUrl != '')
                ? CircleAvatar(
                    radius: 40, backgroundImage: NetworkImage(imgUrl))
                : CircleAvatar(radius: 40, child: Icon(Icons.person)),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(username,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('${city} > ${gu} > ${dong}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${rating.toStringAsFixed(2)} (${ratingCount})'),
                      TextButton(
                        onPressed: () {},
                        child: Text('리뷰'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
