import 'package:flutter/material.dart';
import '../utils/shared_preferences_helper.dart';

class RegisterPage3 extends StatefulWidget {
  @override
  _RegisterPage3State createState() => _RegisterPage3State();
}

class _RegisterPage3State extends State<RegisterPage3> {
  late TextEditingController _idController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _emailController;
  bool _passwordsMatch = true;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _emailController = TextEditingController();
    _loadData();
  }

  Future<void> _loadData() async {
    final id = await SharedPreferencesHelper.getData('id');
    final password = await SharedPreferencesHelper.getData('password');
    final confirmPassword =
        await SharedPreferencesHelper.getData('confirmPassword');
    final email = await SharedPreferencesHelper.getData('email');

    setState(() {
      _idController.text = id ?? '';
      _passwordController.text = password ?? '';
      _confirmPasswordController.text = confirmPassword ?? '';
      _emailController.text = email ?? '';
    });

    _validateForm();
  }

  Future<void> _saveData() async {
    await SharedPreferencesHelper.saveData('id', _idController.text);
    await SharedPreferencesHelper.saveData(
        'password', _passwordController.text);
    await SharedPreferencesHelper.saveData(
        'confirmPassword', _confirmPasswordController.text);
    await SharedPreferencesHelper.saveData('email', _emailController.text);
  }

  Future<void> _printAndResetFields() async {
    final name = await SharedPreferencesHelper.getData('name');
    final birthYear = await SharedPreferencesHelper.getData('BirthYear');
    final birthMonth = await SharedPreferencesHelper.getData('BirthMonth');
    final birthDay = await SharedPreferencesHelper.getData('BirthDay');
    final contact = await SharedPreferencesHelper.getData('contact');
    final address2 = await SharedPreferencesHelper.getData('address2');
    final gender = await SharedPreferencesHelper.getData('gender');
    final type = await SharedPreferencesHelper.getData('type');
    final dong = await SharedPreferencesHelper.getData('dong');
    final university = await SharedPreferencesHelper.getData('university');
    final guardianContact1 =
        await SharedPreferencesHelper.getData('guardianContact1');
    final guardianContact2 =
        await SharedPreferencesHelper.getData('guardianContact2');
    final id = await SharedPreferencesHelper.getData('id');
    final password = await SharedPreferencesHelper.getData('password');
    final confirmPassword =
        await SharedPreferencesHelper.getData('confirmPassword');
    final email = await SharedPreferencesHelper.getData('email');

    print('Saved Data:');
    print('name: $name');
    print('birthYear: $birthYear');
    print('birthMonth: $birthMonth');
    print('birthDay: $birthDay');
    print('contact: $contact');
    print('address2: $address2');
    print('gender: $gender');
    print('type: $type');
    print('dong: $dong');
    print('university: $university');
    print('guardianContact1: $guardianContact1');
    print('guardianContact2: $guardianContact2');
    print('id: $id');
    print('password: $password');
    print('confirmPassword: $confirmPassword');
    print('email: $email');

    await SharedPreferencesHelper.clearData();
    _idController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _emailController.clear();
    setState(() {
      _passwordsMatch = true;
      _isFormValid = false;
    });
  }

  void _checkPasswordsMatch() {
    setState(() {
      _passwordsMatch =
          _passwordController.text == _confirmPasswordController.text;
      _validateForm();
    });
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _idController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _passwordsMatch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입 (3/3)'),
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
                  Text('ID', style: TextStyle(fontSize: 15)),
                  TextField(
                    controller: _idController,
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
                  Text('비밀번호', style: TextStyle(fontSize: 15)),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    onChanged: (text) {
                      _checkPasswordsMatch();
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
                  Text('비밀번호 확인', style: TextStyle(fontSize: 15)),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    onChanged: (text) {
                      _checkPasswordsMatch();
                    },
                  ),
                ],
              ),
            ),
            if (!_passwordsMatch)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '비밀번호가 일치하지 않습니다.',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이메일 주소', style: TextStyle(fontSize: 15)),
                  TextField(
                    controller: _emailController,
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isFormValid
                  ? () async {
                      await _saveData();
                      await _printAndResetFields();
                      Navigator.pushNamed(context, '/');
                    }
                  : null,
              child: Text('완료'),
            ),
          ],
        ),
      ),
    );
  }
}
