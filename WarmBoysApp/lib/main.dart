import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/custom_auth_provider.dart';

import 'screens/register/register_select_screen_0.dart';
import 'screens/index/register_mate_index.dart';
import 'screens/index/register_senior_index.dart';
import 'screens/login_screen.dart';
import 'screens/main/education_screen.dart';
import 'screens/index/main_index.dart';
import 'screens/post/post_senior_my_screen.dart'; // 시니어 자신의 포스트
import 'screens/post/post_senior_screen.dart'; // 시니어 다른 사람의 포스트
import 'screens/post/post_mate_screen.dart'; // 메이트 포스트

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CustomAuthProvider>(
      create: (context) => CustomAuthProvider(),
      child: MaterialApp(
        initialRoute: '/login',
        routes: {
          '/register': (context) =>
              RegisterSelectScreen0(), // 회원가입 스크린(회원 유형 선택)
          '/registerMate': (context) => RegisterMateIndex(), // 회원가입 스크린(메이트)
          '/registerSenior': (context) =>
              RegisterSeniorIndex(), // 회원가입 스크린(시니어)
          '/login': (context) => LoginScreen(), // 로그인 스크린
          '/education': (context) => EducationScreen(), // 교육 영상 스크린
          '/main': (context) => MainIndex(), // 메인(홈, 매칭, 채팅, 교환)
          '/post_senior_my_screen': (context) =>
              PostSeniorMyScreen(), // 시니어 자신의 포스트
          '/post_senior_screen': (context) =>
              PostSeniorScreen(), // 시니어 다른 사람의 포스트
          '/post_mate_screen': (context) => PostMateScreen(), // 메이트 포스트
        },
      ),
    );
  }
}
