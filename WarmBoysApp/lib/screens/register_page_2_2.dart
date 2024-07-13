import 'package:flutter/material.dart';
import '../utils/shared_preferences_helper.dart';

class RegisterPage2_2 extends StatefulWidget {
  @override
  _RegisterPage2_2State createState() => _RegisterPage2_2State();
}

class _RegisterPage2_2State extends State<RegisterPage2_2> {
  late TextEditingController _guardianContact1Controller;
  late TextEditingController _guardianContact2Controller;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _guardianContact1Controller = TextEditingController();
    _guardianContact2Controller = TextEditingController();
    _loadData();
    _guardianContact1Controller.addListener(_validateForm);
    _guardianContact2Controller.addListener(_validateForm);
  }

  Future<void> _loadData() async {
    final guardianContact1 =
        await SharedPreferencesHelper.getData('guardianContact1');
    final guardianContact2 =
        await SharedPreferencesHelper.getData('guardianContact2');

    setState(() {
      _guardianContact1Controller.text = guardianContact1 ?? '';
      _guardianContact2Controller.text = guardianContact2 ?? '';
    });

    _validateForm();
  }

  Future<void> _saveData() async {
    await SharedPreferencesHelper.saveData(
        'guardianContact1', _guardianContact1Controller.text);
    await SharedPreferencesHelper.saveData(
        'guardianContact2', _guardianContact2Controller.text);
    await SharedPreferencesHelper.clearDataByKey('university');
  }

  void _resetFields() async {
    await SharedPreferencesHelper.clearData();
    _guardianContact1Controller.clear();
    _guardianContact2Controller.clear();
    setState(() {
      _isFormValid = false;
    });
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _guardianContact1Controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입 (2/3) - 노인'),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('보호자 연락처 1', style: TextStyle(fontSize: 15)),
                  TextField(
                    controller: _guardianContact1Controller,
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('보호자 연락처 2', style: TextStyle(fontSize: 15)),
                  TextField(
                    controller: _guardianContact2Controller,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isFormValid
                  ? () async {
                      await _saveData();
                      Navigator.pushNamed(context, '/register3');
                    }
                  : null,
              child: Text('다음'),
            ),
          ],
        ),
      ),
    );
  }
}
