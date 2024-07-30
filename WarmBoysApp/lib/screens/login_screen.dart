import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/custom_auth_provider.dart'; // 변경된 파일 이름과 클래스 이름을 반영

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _emailDomain = 'gmail.com';
  bool _isButtonDisabled = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkFields);
    _passwordController.addListener(_checkFields);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _checkFields() {
    if (mounted) {
      setState(() {
        _isButtonDisabled =
            _emailController.text.isEmpty || _passwordController.text.isEmpty;
      });
    }
  }

  Future<void> _login(BuildContext context) async {
    String email = '${_emailController.text}@$_emailDomain';
    String password = _passwordController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Provider.of<CustomAuthProvider>(context, listen: false)
          .setUserCredential(userCredential);

      // 콘솔에 uid 출력
      print("----------------로그인완료----------------");
      print("User UID: ${userCredential.user?.uid}");

      // Firestore에서 isVerified 필드 값 가져오기
      bool isVerified = await _checkIsVerified(userCredential.user?.uid);
      print("교육영상 이수여부: ${isVerified ? 'O' : 'X'}");

      if (!isVerified) {
        print("교육 영상 시청 스크린으로 이동합니다.");
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/education');
        }
      } else {
        print("홈 스크린으로 이동합니다.");
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/main');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = '아이디 또는 비밀번호가 잘못되었습니다.';
        });
      }
    }
  }

  Future<bool> _checkIsVerified(String? uid) async {
    if (uid == null) return false;

    final doc =
        await FirebaseFirestore.instance.collection('user').doc(uid).get();
    if (doc.exists) {
      return doc.data()?['isVerified'] ?? false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8C2BD), // 배경색 설정
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 타이틀 로고
              Center(
                child: Image.asset(
                  'assets/logos/apptitle.png', // 타이틀 로고 이미지 경로
                  width: 210, // 로고 너비
                  height: 100, // 로고 높이
                ),
              ),
              SizedBox(height: 5), // 타이틀 로고와 회사 로고 사이 여백
              // 팀 로고
              Center(
                child: Image.asset(
                  'assets/logos/company.png', // 로고 이미지 경로
                  width: 200, // 로고 너비
                  height: 50, // 로고 높이
                ),
              ),
              SizedBox(height: 60), // 로고와 입력 필드 사이 여백
              // Email Input
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 54, // 이메일 텍스트 필드의 높이 지정
                      child: TextField(
                        controller: _emailController,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          hintText: '이메일',
                          hintStyle: TextStyle(
                            color: Color(0xFFB6B6B6),
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal, // Medium
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '@',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 145, // 드롭다운 버튼의 폭 지정
                    height: 54, // 이메일 텍스트 필드와 동일한 높이로 설정
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButton<String>(
                      value: _emailDomain,
                      underline: SizedBox(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      items: <String>[
                        'gmail.com',
                        'naver.com',
                        'yahoo.com',
                        'daum.net'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _emailDomain = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Password Input
              Container(
                height: 54, // 비밀번호 텍스트 필드의 높이 지정
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: '비밀번호',
                    hintStyle: TextStyle(
                      color: Color(0xFFB6B6B6),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal, // Medium
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  ),
                ),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 20),
              // Login Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonDisabled
                        ? Colors.grey
                        : Color.fromARGB(255, 70, 94, 219),
                    padding: EdgeInsets.symmetric(vertical: 10), // 높이 조절
                  ),
                  onPressed: _isButtonDisabled ? null : () => _login(context),
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              // Sign Up Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10), // 높이 조절
                  ),
                  onPressed: () {
                    // 회원가입 버튼을 눌렀을 때 입력 필드를 초기화
                    _emailController.clear();
                    _passwordController.clear();
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    '따시게 가입하기',
                    style: TextStyle(
                      color: Color.fromARGB(255, 254, 169, 161),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
