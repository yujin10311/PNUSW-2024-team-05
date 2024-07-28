import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:warm_boys/providers/custom_auth_provider.dart';

class EducationScreen extends StatefulWidget {
  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  Future<void> _updateIsVerified() async {
    final customAuthProvider =
        Provider.of<CustomAuthProvider>(context, listen: false);
    final userCredential = customAuthProvider.userCredential;

    if (userCredential != null) {
      final user = userCredential.user;
      final userId = user?.uid;

      if (userId != null) {
        final firestore = FirebaseFirestore.instance;
        try {
          await firestore.collection('user').doc(userId).update({
            'isVerified': true,
          });
          Navigator.pushReplacementNamed(context, '/main');
        } catch (e) {
          print("Error updating isVerified: $e"); // 에러 메시지 출력
        }
      } else {
        // Handle error: user ID is null
        print("User ID is null");
      }
    } else {
      // Handle error: userCredential is null
      print("UserCredential is null");
    }
  }

  void _logOut() {
    final customAuthProvider =
        Provider.of<CustomAuthProvider>(context, listen: false);
    customAuthProvider.logOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('교육 영상 페이지'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _logOut,
        ),
      ),
      body: Column(
        children: [],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            await _updateIsVerified();
            print("------------교육영상 이수완료------------");
            print("홈 스크린으로 이동합니다.");
          },
          child: Text('다음'),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
          ),
        ),
      ),
    );
  }
}
