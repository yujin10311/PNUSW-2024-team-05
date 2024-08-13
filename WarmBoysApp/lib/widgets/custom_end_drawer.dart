import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/custom_auth_provider.dart';
import '../screens/login_screen.dart';
import '../screens/service/customer_service_screen.dart';
import '../screens/profile/profile_mate_screen.dart';
import '../screens/profile/profile_senior_screen.dart';
import '../screens/history/history_screen.dart';

class CustomEndDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final customAuthProvider =
        Provider.of<CustomAuthProvider>(context, listen: false);
    final userInfo = Provider.of<CustomAuthProvider>(context).userInfo!;
    final username = userInfo?['username'] ?? '사용자 이름';
    final uid = Provider.of<CustomAuthProvider>(context).uid;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: customAuthProvider.profileImageBytes != null
                      ? MemoryImage(customAuthProvider.profileImageBytes!)
                      : AssetImage('assets/default_profile.png')
                          as ImageProvider,
                ),
                SizedBox(height: 10),
                Text(
                  username,
                  style: TextStyle(
                    color: Color.fromARGB(255, 24, 24, 24),
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('내 프로필'),
            onTap: () {
              if (userInfo['memberType'] == '메이트') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileMateScreen(),
                  ),
                );
              } else if (userInfo['memberType'] == '시니어') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileSeniorScreen(),
                  ),
                );
              } else
                print("잘못된 회원 유형입니다.");
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('활동 기록'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HistoryScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('고객센터'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CustomerServiceScreen(uid: uid!),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('로그아웃'),
            onTap: () {
              // CustomAuthProvider의 logOut 메서드를 호출하고 로그인 페이지로 이동
              Provider.of<CustomAuthProvider>(context, listen: false)
                  .logOut()
                  .then(
                (_) {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          LoginScreen(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
