import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/register_state.dart';

class RegisterPage2 extends StatefulWidget {
  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  @override
  Widget build(BuildContext context) {
    final registerState = Provider.of<RegisterState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입 (2/2)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(
                'ID', 'id', registerState.id, registerState.updateField),
            _buildTextField('비밀번호', 'password', registerState.password,
                registerState.updateField,
                obscureText: true),
            _buildTextField(
              '비밀번호 확인',
              'confirmPassword',
              registerState.confirmPassword,
              (key, value) {
                registerState.updateField(key, value);
                _checkPasswordMatch(value);
              },
              obscureText: true,
            ),
            if (registerState.password != registerState.confirmPassword)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '비밀번호가 일치하지 않습니다.',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            _buildTextField('이메일 주소', 'email', registerState.email,
                registerState.updateField),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('이전'),
                ),
                ElevatedButton(
                  onPressed: registerState.isFormValid
                      ? () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false);
                        }
                      : null,
                  child: Text('완료'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _checkPasswordMatch(String value) {
    final registerState = Provider.of<RegisterState>(context, listen: false);
    registerState.updateField('confirmPassword', value);
  }

  Widget _buildTextField(String label, String key, String value,
      Function(String, String) onChanged,
      {bool obscureText = false, Function(String)? onChangedLocal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 15)),
          TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            onChanged: (text) {
              onChanged(key, text);
              if (onChangedLocal != null) {
                onChangedLocal(text);
              }
            },
          ),
        ],
      ),
    );
  }
}
