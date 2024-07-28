import 'package:flutter/material.dart';
import '../../utils/shared_preferences_helper.dart';

// 회원가입 스크린 3(메이트)
class RegisterMateScreen3 extends StatefulWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;

  RegisterMateScreen3({required this.onNextPage, required this.onPreviousPage});

  @override
  _RegisterMateScreen3State createState() => _RegisterMateScreen3State();
}

class _RegisterMateScreen3State extends State<RegisterMateScreen3> {
  String _selectedGender = '남성';
  String? _selectedAge;
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _additionalInfoController;

  List<String> _ageOptions = List.generate(
      46, (index) => '${19 + index}세(${DateTime.now().year - (19 + index)}년생)');

  bool get _isFormValid {
    return _nameController.text.isNotEmpty &&
        _selectedAge != null &&
        _phoneNumberController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _additionalInfoController = TextEditingController();
    _loadFormData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _additionalInfoController.dispose();
    super.dispose();
  }

  Future<void> _loadFormData() async {
    _nameController.text =
        await SharedPreferencesHelper.getByKey('_username') ?? '';
    _selectedAge = await SharedPreferencesHelper.getByKey('_age');
    _selectedGender = await SharedPreferencesHelper.getByKey('_gender') ?? '남성';
    _phoneNumberController.text =
        await SharedPreferencesHelper.getByKey('_phoneNum') ?? '';
    _additionalInfoController.text =
        await SharedPreferencesHelper.getByKey('_addInfo') ?? '';
    setState(() {});
  }

  Future<void> _saveFormData() async {
    await SharedPreferencesHelper.saveData('_username', _nameController.text);
    await SharedPreferencesHelper.saveData('_age', _selectedAge ?? '');
    await SharedPreferencesHelper.saveData('_gender', _selectedGender);
    await SharedPreferencesHelper.saveData(
        '_phoneNum', _phoneNumberController.text);
    await SharedPreferencesHelper.saveData(
        '_addInfo', _additionalInfoController.text);
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
                    // 사진 등록 기능 추가 필요
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
                        Text("회원님 휴대폰 번호를 작성해주세요.",
                            style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Text("필수",
                            style: TextStyle(fontSize: 12, color: Colors.red)),
                      ],
                    ),
                    TextField(
                      controller: _phoneNumberController,
                      maxLength: 11,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
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
                        Text("피부양자가 추가적으로 알아야 할 내용이 있나요?",
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
                        _onFormFieldChanged();
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
