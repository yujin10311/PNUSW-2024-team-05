import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/custom_auth_provider.dart';
import '../screens/login_screen.dart';

class CustomEndDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<CustomAuthProvider>(context).userInfo;
    final username = userInfo?['username'] ?? '사용자 이름';

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/icons/profile_blank.png'),
                ),
                SizedBox(height: 10),
                Text(
                  username,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('프로필 수정'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('내 크레딧'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('로그아웃'),
            onTap: () {
              // CustomAuthProvider의 logOut 메서드를 호출하고 로그인 페이지로 이동
              Provider.of<CustomAuthProvider>(context, listen: false)
                  .logOut()
                  .then((_) {
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      LoginScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ));
              });
            },
          ),
        ],
      ),
    );
  }
}
