import 'package:flutter/material.dart';
import 'package:warm_boys/screens/service/write_inquiry_screen.dart';

class CustomerServiceScreen extends StatelessWidget {
  final String uid;

  CustomerServiceScreen({required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '고객 센터',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    '따뜻한 청년들입니다.',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '무엇을 도와드릴까요?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 7,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "자주 묻는 질문",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // Q1 눌렀을 때의 동작
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "Q",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 28, 125, 204),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "자주 묻는 질문 1",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[200], thickness: 1),
                  GestureDetector(
                    onTap: () {
                      // Q1 눌렀을 때의 동작
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "Q",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 28, 125, 204),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "자주 묻는 질문 2",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[200], thickness: 1),
                  GestureDetector(
                    onTap: () {
                      // Q1 눌렀을 때의 동작
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "Q",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 28, 125, 204),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "자주 묻는 질문 3",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[200], thickness: 1),
                  GestureDetector(
                    onTap: () {
                      // Q1 눌렀을 때의 동작
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "Q",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 28, 125, 204),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "자주 묻는 질문 4",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[200], thickness: 1),
                  GestureDetector(
                    onTap: () {
                      // Q1 눌렀을 때의 동작
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "Q",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 28, 125, 204),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "자주 묻는 질문 5",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[200], thickness: 1),
                  GestureDetector(
                    onTap: () {
                      // Q1 눌렀을 때의 동작
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "Q",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 28, 125, 204),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "자주 묻는 질문 6",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[200], thickness: 1),
                  GestureDetector(
                    onTap: () {
                      // Q1 눌렀을 때의 동작
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "Q",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 28, 125, 204),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "자주 묻는 질문 7",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[200], thickness: 1),
                  GestureDetector(
                    onTap: () {
                      // Q1 눌렀을 때의 동작
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "Q",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 28, 125, 204),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "자주 묻는 질문 8",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[200], thickness: 1),
                  GestureDetector(
                    onTap: () {
                      // Q1 눌렀을 때의 동작
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "Q",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 28, 125, 204),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "자주 묻는 질문 9",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[200], thickness: 1),
                  GestureDetector(
                    onTap: () {
                      // Q1 눌렀을 때의 동작
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "Q",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 28, 125, 204),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "자주 묻는 질문 10",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey[200], thickness: 1),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 150, // 버튼 너비를 조절
        child: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WriteInquiryScreen(uid: uid!),
              ),
            );
          },
          icon: Icon(Icons.edit, color: Colors.white),
          label: Text(
            '문의하기',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
