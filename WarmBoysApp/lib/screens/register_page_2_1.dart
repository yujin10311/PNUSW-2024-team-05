import 'package:flutter/material.dart';
import '../utils/shared_preferences_helper.dart';
import '../widgets/dropdown_with_label.dart';

class RegisterPage2_1 extends StatefulWidget {
  @override
  _RegisterPage2_1State createState() => _RegisterPage2_1State();
}

class _RegisterPage2_1State extends State<RegisterPage2_1> {
  final List<String> universityList = [
    '경성대학교',
    '고신대학교',
    '경남정보대학교',
    '대동대학교',
    '동명대학교',
    '동서대학교',
    '동아대학교',
    '동의대학교',
    '부산대학교',
    '부산가톨릭대학교',
    '부산경상대학교',
    '부산교육대학교',
    '부산과학기술대학교',
    '부산보건대학교',
    '부산여자대학교',
    '부산예술대학교',
    '부산외국어대학교',
    '신라대학교',
    '영산대학교',
    '인제대학교',
    '한국폴리텍7대학',
  ];
  String _university = '경성대학교';

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
