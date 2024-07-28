import 'package:flutter/material.dart';
import '../../utils/shared_preferences_helper.dart';

// 회원가입 스크린 3(시니어)
class RegisterSeniorScreen3 extends StatefulWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;

  RegisterSeniorScreen3(
      {required this.onNextPage, required this.onPreviousPage});

  @override
  _RegisterSeniorScreen3State createState() => _RegisterSeniorScreen3State();
}

class _RegisterSeniorScreen3State extends State<RegisterSeniorScreen3> {
  String _selectedGender = '남성';
  String? _selectedAge;
  String? _name;
  String? _contact;
  String? _emergencyContact;
  String? _additionalInfo;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _emergencyContactController = TextEditingController();
  TextEditingController _additionalInfoController = TextEditingController();

  List<String> _ageOptions = List.generate(
      56, (index) => '${65 + index}세(${DateTime.now().year - (65 + index)}년생)');

  bool get _isFormValid {
    return _name != null &&
        _name!.isNotEmpty &&
        _selectedAge != null &&
        _contact != null &&
        _contact!.isNotEmpty &&
        _emergencyContact != null &&
        _emergencyContact!.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _loadFormData();
  }

  Future<void> _loadFormData() async {
    _name = await SharedPreferencesHelper.getByKey('_username');
    _selectedAge = await SharedPreferencesHelper.getByKey('_age');
    _selectedGender = await SharedPreferencesHelper.getByKey('_gender') ?? '남성';
    _contact = await SharedPreferencesHelper.getByKey('_phoneNum');
    _emergencyContact = await SharedPreferencesHelper.getByKey('_phoneNum2');
    _additionalInfo = await SharedPreferencesHelper.getByKey('_addInfo');

    setState(() {
      _nameController.text = _name ?? '';
      _contactController.text = _contact ?? '';
      _emergencyContactController.text = _emergencyContact ?? '';
      _additionalInfoController.text = _additionalInfo ?? '';
    });
  }

  Future<void> _saveFormData() async {
    await SharedPreferencesHelper.saveData('_username', _name ?? '');
    await SharedPreferencesHelper.saveData('_age', _selectedAge ?? '');
    await SharedPreferencesHelper.saveData('_gender', _selectedGender);
    await SharedPreferencesHelper.saveData('_phoneNum', _contact ?? '');
    await SharedPreferencesHelper.saveData(
        '_phoneNum2', _emergencyContact ?? '');
    await SharedPreferencesHelper.saveData('_addInfo', _additionalInfo ?? '');
  }

  void _onFormFieldChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원 개인 정보'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.onPreviousPage,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '사진을 등록해주세요.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.grey[300],
                  child: Icon(Icons.photo, size: 100, color: Colors.grey[700]),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // 사진 등록 기능 추가
                  },
                  child: Text('사진 등록'),
                ),
              ),
              SizedBox(height: 30),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("이름", style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Text("필수",
                            style: TextStyle(fontSize: 12, color: Colors.red)),
                      ],
                    ),
                    SizedBox(
                      width: 150,
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _name = value;
                          _onFormFieldChanged();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("나이", style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Text("필수",
                            style: TextStyle(fontSize: 12, color: Colors.red)),
                      ],
                    ),
                    Container(
                      width: 200,
                      child: DropdownButtonFormField<String>(
                        value: _selectedAge,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                        hint: Text('나이 선택'),
                        items: _ageOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          _selectedAge = newValue;
                          _onFormFieldChanged();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("성별을 선택해주세요.", style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text("중복 선택 불가",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.red)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedGender = '남성';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedGender == '남성'
                                  ? Colors.blue
                                  : Colors.grey,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8.0), // 모서리 곡률 설정
                              ),
                            ),
                            child: Text('남성'),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedGender = '여성';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedGender == '여성'
                                  ? Colors.blue
                                  : Colors.grey,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8.0), // 모서리 곡률 설정
                              ),
                            ),
                            child: Text('여성'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("회원님 연락처를 작성해주세요.",
                            style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Text("필수",
                            style: TextStyle(fontSize: 12, color: Colors.red)),
                      ],
                    ),
                    TextField(
                      controller: _contactController,
                      maxLength: 11,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _contact = value;
                        _onFormFieldChanged();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("비상시 연락 가능한 번호가 있나요?",
                            style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Text("필수",
                            style: TextStyle(fontSize: 12, color: Colors.red)),
                      ],
                    ),
                    TextField(
                      controller: _emergencyContactController,
                      maxLength: 11,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _emergencyContact = value;
                        _onFormFieldChanged();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("메이트가 추가적으로 알아야 할 내용이 있나요?",
                            style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text("선택",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.red)),
                        ),
                      ],
                    ),
                    TextField(
                      controller: _additionalInfoController,
                      maxLines: 3,
                      maxLength: 100,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _additionalInfo = value;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _isFormValid
              ? () async {
                  await _saveFormData();
                  widget.onNextPage();
                }
              : null,
          child: Text('다음'),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
          ),
        ),
      ),
    );
  }
}
