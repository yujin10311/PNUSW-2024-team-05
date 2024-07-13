import 'package:flutter/material.dart';
import '../utils/shared_preferences_helper.dart';
import '../widgets/dropdown_with_label.dart';

class RegisterPage2_1 extends StatefulWidget {
  @override
  _RegisterPage2_1State createState() => _RegisterPage2_1State();
}

class _RegisterPage2_1State extends State<RegisterPage2_1> {
  final List<String> universityList = [
    '서울대학교',
    '연세대학교',
    '고려대학교',
    '성균관대학교',
    '한양대학교',
  ];
  String _university = '서울대학교';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final university = await SharedPreferencesHelper.getData('university');

    setState(() {
      _university = university ?? universityList[0];
    });
  }

  Future<void> _saveData() async {
    await SharedPreferencesHelper.saveData('university', _university);
    await SharedPreferencesHelper.clearDataByKey('guardianContact1');
    await SharedPreferencesHelper.clearDataByKey('guardianContact2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입 (2/3) - 청년'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownWithLabel(
              label: '소재 대학',
              value: _university,
              items: universityList,
              onChanged: (String? value) {
                setState(() {
                  _university = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _saveData();
                Navigator.pushNamed(context, '/register3');
              },
              child: Text('다음'),
            ),
          ],
        ),
      ),
    );
  }
}
