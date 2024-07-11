import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/register_state.dart';

class RegisterPage1 extends StatefulWidget {
  @override
  _RegisterPage1State createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  @override
  void initState() {
    super.initState();
    final registerState = Provider.of<RegisterState>(context, listen: false);
    registerState.reset();
  }

  void _updateTypeAndClearFields(String value) {
    final registerState = Provider.of<RegisterState>(context, listen: false);
    setState(() {
      registerState.updateField('type', value);
      if (value == '청년') {
        registerState.clearField('guardianContact');
      } else if (value == '노인') {
        registerState.clearField('university');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final registerState = Provider.of<RegisterState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입 (1/2)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(
                '이름', 'name', registerState.name, registerState.updateField),
            _buildTextField(
                '나이', 'age', registerState.age, registerState.updateField),
            _buildRadioGroup('성별', ['남성', '여성'], registerState.gender, (value) {
              registerState.updateField('gender', value);
            }),
            _buildRadioGroup('가입 유형', ['노인', '청년'], registerState.type,
                _updateTypeAndClearFields),
            _buildTextField('연락처', 'contact', registerState.contact,
                registerState.updateField),
            _buildDropdown('주소_1', ['부산 금정구 동1', '부산 금정구 동2', '부산 금정구 동3'],
                registerState.dong, (value) {
              registerState.updateField('dong', value);
            }),
            _buildTextField('주소_2', 'address2', registerState.address2,
                registerState.updateField),
            _buildTextField('소재대학', 'university', registerState.university,
                registerState.updateField,
                enabled: registerState.type == '청년'),
            _buildTextField('보호자 연락처', 'guardianContact',
                registerState.guardianContact, registerState.updateField,
                enabled: registerState.type == '노인'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register2');
              },
              child: Text('다음'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String key, String value,
      Function(String, String) onChanged,
      {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 15)),
          TextField(
            enabled: enabled,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            onChanged: (text) => onChanged(key, text),
            controller: TextEditingController(text: value),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioGroup(String label, List<String> options, String groupValue,
      Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 15)),
          Wrap(
            children: options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: groupValue,
                      onChanged: (value) {
                        onChanged(value!);
                      },
                    ),
                    Text(option),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> options,
      String selectedValue, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 15)),
          DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            onChanged: (String? newValue) {
              onChanged(newValue!);
            },
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
