import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/register_state.dart';

class RegisterPage2 extends StatefulWidget {
  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  late TextEditingController _idController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final registerState = Provider.of<RegisterState>(context, listen: false);

    _idController = TextEditingController(text: registerState.id);
    _passwordController = TextEditingController(text: registerState.password);
    _confirmPasswordController =
        TextEditingController(text: registerState.confirmPassword);
    _emailController = TextEditingController(text: registerState.email);

    _idController.addListener(() {
      registerState.updateField('id', _idController.text);
    });
    _passwordController.addListener(() {
      registerState.updateField('password', _passwordController.text);
    });
    _confirmPasswordController.addListener(() {
      registerState.updateField(
          'confirmPassword', _confirmPasswordController.text);
      _checkPasswordMatch(_confirmPasswordController.text);
    });
    _emailController.addListener(() {
      registerState.updateField('email', _emailController.text);
    });
  }

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
            _buildTextField('ID', _idController),
            _buildTextField('비밀번호', _passwordController, obscureText: true),
            _buildTextField('비밀번호 확인', _confirmPasswordController,
                obscureText: true),
            if (registerState.password != registerState.confirmPassword)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '비밀번호가 일치하지 않습니다.',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            _buildTextField('이메일 주소', _emailController),
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

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 15)),
          TextField(
            controller: controller,
            obscureText: obscureText,
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
    );
  }
}
