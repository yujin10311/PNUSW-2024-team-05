import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/register_state.dart';

class RegisterPage1 extends StatefulWidget {
  @override
  _RegisterPage1State createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _contactController;
  late TextEditingController _address2Controller;
  late TextEditingController _universityController;
  late TextEditingController _guardianContactController;

  @override
  void initState() {
    super.initState();
    final registerState = Provider.of<RegisterState>(context, listen: false);

    _nameController = TextEditingController(text: registerState.name);
    _ageController = TextEditingController(text: registerState.age);
    _contactController = TextEditingController(text: registerState.contact);
    _address2Controller = TextEditingController(text: registerState.address2);
    _universityController =
        TextEditingController(text: registerState.university);
    _guardianContactController =
        TextEditingController(text: registerState.guardianContact);

    _nameController.addListener(() {
      registerState.updateField('name', _nameController.text);
    });
    _ageController.addListener(() {
      registerState.updateField('age', _ageController.text);
    });
    _contactController.addListener(() {
      registerState.updateField('contact', _contactController.text);
    });
    _address2Controller.addListener(() {
      registerState.updateField('address2', _address2Controller.text);
    });
    _universityController.addListener(() {
      registerState.updateField('university', _universityController.text);
    });
    _guardianContactController.addListener(() {
      registerState.updateField(
          'guardianContact', _guardianContactController.text);
    });
  }

  void _updateTypeAndClearFields(String value) {
    final registerState = Provider.of<RegisterState>(context, listen: false);
    setState(() {
      registerState.updateField('type', value);
      if (value == '청년') {
        registerState.clearField('guardianContact');
        _guardianContactController.clear();
      } else if (value == '노인') {
        registerState.clearField('university');
        _universityController.clear();
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
            _buildTextField('이름', _nameController),
            _buildTextField('나이', _ageController),
            _buildRadioGroup('성별', ['남성', '여성'], registerState.gender, (value) {
              setState(() {
                registerState.updateField('gender', value);
              });
            }),
            _buildRadioGroup('가입 유형', ['노인', '청년'], registerState.type,
                _updateTypeAndClearFields),
            _buildTextField('연락처', _contactController),
            _buildDropdown('주소_1', ['부산 금정구 동1', '부산 금정구 동2', '부산 금정구 동3'],
                registerState.dong, (value) {
              setState(() {
                registerState.updateField('dong', value);
              });
            }),
            _buildTextField('주소_2', _address2Controller),
            _buildTextField('소재대학', _universityController,
                enabled: registerState.type == '청년'),
            _buildTextField('보호자 연락처', _guardianContactController,
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
              setState(() {
                onChanged(newValue!);
              });
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
