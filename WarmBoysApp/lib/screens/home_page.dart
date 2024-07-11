import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈페이지'),
      ),
      body: ListView(
        children: [
          ImageCard(
            imagePath: 'assets/icons/profile_blank.png',
            title: '제목 1',
            date: '2024-07-10',
            time: '12:00 PM',
            description: '간단한 설명 1',
          ),
          ImageCard(
            imagePath: 'assets/icons/profile_blank.png',
            title: '제목 2',
            date: '2024-07-11',
            time: '01:00 PM',
            description: '간단한 설명 2',
          ),
          ImageCard(
            imagePath: 'assets/icons/profile_blank.png',
            title: '제목 3',
            date: '2024-07-12',
            time: '02:00 PM',
            description: '간단한 설명 3',
          ),
          ImageCard(
            imagePath: 'assets/icons/profile_blank.png',
            title: '제목 3',
            date: '2024-07-12',
            time: '02:00 PM',
            description: '간단한 설명 3',
          ),
          ImageCard(
            imagePath: 'assets/icons/profile_blank.png',
            title: '제목 3',
            date: '2024-07-12',
            time: '02:00 PM',
            description: '간단한 설명 3',
          ),
          // 원하는 만큼 이미지 카드 추가
        ],
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String date;
  final String time;
  final String description;

  ImageCard({
    required this.imagePath,
    required this.title,
    required this.date,
    required this.time,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(date),
                  Text(time),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
