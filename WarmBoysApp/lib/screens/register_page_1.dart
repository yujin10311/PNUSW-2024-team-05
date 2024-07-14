import 'package:flutter/material.dart';
import '../utils/shared_preferences_helper.dart';
import '../widgets/radio_button_group.dart';
import '../widgets/dropdown.dart';

class RegisterPage1 extends StatefulWidget {
  @override
  _RegisterPage1State createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  late TextEditingController _nameController;
  late TextEditingController _contactController;
  late TextEditingController _address2Controller;
  String _gender = '남성';
  String _type = '청년';
  String _dong = '구서1동';
  String _selectedYear = DateTime.now().year.toString();
  String _selectedMonth = '01';
  String _selectedDay = '01';
  bool _isFormValid = false;

  List<String> _years = List<String>.generate(
      100, (index) => (DateTime.now().year - index).toString());
  List<String> _months = List<String>.generate(
      12, (index) => (index + 1).toString().padLeft(2, '0'));
  List<String> _days = List<String>.generate(
      31, (index) => (index + 1).toString().padLeft(2, '0'));

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _contactController = TextEditingController();
    _address2Controller = TextEditingController();
    _loadData();
  }

  Future<void> _loadData() async {
    final name = await SharedPreferencesHelper.getData('name');
    final birthYear = await SharedPreferencesHelper.getData('BirthYear');
    final birthMonth = await SharedPreferencesHelper.getData('BirthMonth');
    final birthDay = await SharedPreferencesHelper.getData('BirthDay');
    final contact = await SharedPreferencesHelper.getData('contact');
    final address2 = await SharedPreferencesHelper.getData('address2');
    final gender = await SharedPreferencesHelper.getData('gender');
    final type = await SharedPreferencesHelper.getData('type');
    final dong = await SharedPreferencesHelper.getData('dong');

    setState(() {
      _nameController.text = name ?? '';
      _selectedYear = birthYear ?? DateTime.now().year.toString();
      _selectedMonth = birthMonth ?? '01';
      _selectedDay = birthDay ?? '01';
      _contactController.text = contact ?? '';
      _address2Controller.text = address2 ?? '';
      _gender = gender ?? '남성';
      _type = type ?? '청년';
      _dong = dong ?? '구서1동';
    });

    _validateForm();
  }

  Future<void> _saveData() async {
    await SharedPreferencesHelper.saveData('name', _nameController.text);
    await SharedPreferencesHelper.saveData('BirthYear', _selectedYear);
    await SharedPreferencesHelper.saveData('BirthMonth', _selectedMonth);
    await SharedPreferencesHelper.saveData('BirthDay', _selectedDay);
    await SharedPreferencesHelper.saveData('contact', _contactController.text);
    await SharedPreferencesHelper.saveData(
        'address2', _address2Controller.text);
    await SharedPreferencesHelper.saveData('gender', _gender);
    await SharedPreferencesHelper.saveData('type', _type);
    await SharedPreferencesHelper.saveData('dong', _dong);
  }

  void _resetFields() async {
    await SharedPreferencesHelper.clearData();
    _nameController.clear();
    _contactController.clear();
    _address2Controller.clear();
    setState(() {
      _selectedYear = DateTime.now().year.toString();
      _selectedMonth = '01';
      _selectedDay = '01';
      _gender = '남성';
      _type = '청년';
      _dong = '구서1동';
      _isFormValid = false;
    });
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _nameController.text.isNotEmpty &&
          _selectedYear.isNotEmpty &&
          _selectedMonth.isNotEmpty &&
          _selectedDay.isNotEmpty &&
          _contactController.text.isNotEmpty &&
          _address2Controller.text.isNotEmpty &&
          _gender.isNotEmpty &&
          _type.isNotEmpty &&
          _dong.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입 (1/3)'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _resetFields();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField('이름', _nameController),
            _buildBirthdayField(),
            RadioButtonGroup(
              label: '성별',
              options: ['남성', '여성'],
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                  _validateForm();
                });
              },
            ),
            RadioButtonGroup(
              label: '가입 유형',
              options: ['노인', '청년'],
              groupValue: _type,
              onChanged: (value) {
                setState(() {
                  _type = value;
                  _validateForm();
                });
              },
            ),
            _buildTextField('연락처', _contactController),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('주소_1', style: TextStyle(fontSize: 15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Dropdown(
                        value: _dong,
                        items: [
                          '구서1동',
                          '구서2동',
                          '금사회동동',
                          '금성동',
                          '남산동',
                          '부곡1동',
                          '부곡2동',
                          '부곡3동',
                          '부곡4동',
                          '서1동',
                          '서2동',
                          '서3동',
                          '선두구동',
                          '장전1동',
                          '장전2동',
                          '청룡노포동',
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            _dong = value!;
                            _validateForm();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildTextField('주소_2', _address2Controller),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isFormValid
                  ? () async {
                      await _saveData();
                      if (_type == '청년') {
                        Navigator.pushNamed(context, '/register2_1');
                      } else if (_type == '노인') {
                        Navigator.pushNamed(context, '/register2_2');
                      }
                    }
                  : null,
              child: Text('다음'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 15)),
          TextField(
            controller: controller,
            enabled: enabled,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            onChanged: (text) {
              _validateForm();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBirthdayField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('생년월일', style: TextStyle(fontSize: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dropdown(
                value: _selectedYear,
                items: _years,
                onChanged: (String? value) {
                  setState(() {
                    _selectedYear = value!;
                    _validateForm();
                  });
                },
              ),
              SizedBox(width: 8),
              Text('년', style: TextStyle(fontSize: 15)),
              SizedBox(width: 20),
              Dropdown(
                value: _selectedMonth,
                items: _months,
                onChanged: (String? value) {
                  setState(() {
                    _selectedMonth = value!;
                    _validateForm();
                  });
                },
              ),
              SizedBox(width: 8),
              Text('월', style: TextStyle(fontSize: 15)),
              SizedBox(width: 20),
              Dropdown(
                value: _selectedDay,
                items: _days,
                onChanged: (String? value) {
                  setState(() {
                    _selectedDay = value!;
                    _validateForm();
                  });
                },
              ),
              SizedBox(width: 8),
              Text('일', style: TextStyle(fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }
}
