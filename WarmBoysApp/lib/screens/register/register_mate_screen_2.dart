import 'package:flutter/material.dart';
import '../../utils/shared_preferences_helper.dart';

// 회원가입 스크린 2(메이트)
class RegisterMateScreen2 extends StatefulWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;

  RegisterMateScreen2({required this.onNextPage, required this.onPreviousPage});

  @override
  _RegisterMateScreen2State createState() => _RegisterMateScreen2State();
}

class _RegisterMateScreen2State extends State<RegisterMateScreen2> {
  String selectedCity = '부산광역시';
  String selectedDistrict = '금정구';
  String? selectedSubDistrict;

  Map<String, List<String>> cityDistrictMap = {
    '서울특별시': [],
    '부산광역시': [
      '강서구',
      '금정구',
      '기장군',
      '남구',
      '동구',
      '동래구',
      '부산진구',
      '북구',
      '사상구',
      '사하구',
      '서구',
      '수영구',
      '연제구',
      '영도구',
      '중구',
      '해운대구'
    ],
    '대구광역시': [],
    '인천광역시': [],
    '광주광역시': [],
    '대전광역시': [],
    '울산광역시': [],
    '세종특별자치시': [],
    '경기도': [],
    '강원특별자치도': [],
    '충청북도': [],
    '충청남도': [],
    '전북특별자치도': [],
    '전라남도': [],
    '경상북도': [],
    '경상남도': [],
    '제주특별자치도': [],
  };

  Map<String, List<String>> districtSubDistrictMap = {
    '금정구': [
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
      '청룡노포동'
    ],
  };

  @override
  void initState() {
    super.initState();
    _loadSavedSubDistrict();
  }

  Future<void> _loadSavedSubDistrict() async {
    String? subDistrict = await SharedPreferencesHelper.getByKey('_dong');
    if (subDistrict != null) {
      setState(() {
        selectedSubDistrict = subDistrict;
      });
    } else {
      setState(() {
        selectedSubDistrict = districtSubDistrictMap[selectedDistrict]![0];
      });
    }
  }

  Future<void> _saveLocationData() async {
    await SharedPreferencesHelper.saveData('_city', selectedCity);
    await SharedPreferencesHelper.saveData('_gu', selectedDistrict);
    await SharedPreferencesHelper.saveData('_dong', selectedSubDistrict!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('활동 지역이 어디일까요?'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.onPreviousPage,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: _buildButtonColumn(
                        cityDistrictMap.keys.toList(),
                        selectedCity,
                        (value) {},
                        true, // 1열은 비활성화
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: _buildButtonColumn(
                        cityDistrictMap[selectedCity]!,
                        selectedDistrict,
                        (value) {},
                        true, // 2열은 비활성화
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: _buildButtonColumn(
                        districtSubDistrictMap[selectedDistrict]!,
                        selectedSubDistrict,
                        (value) {
                          setState(() {
                            selectedSubDistrict = value;
                          });
                        },
                        false, // 3열은 활성화
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: selectedSubDistrict != null
              ? () async {
                  await _saveLocationData();
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

  Widget _buildButtonColumn(List<String> items, String? selectedItem,
      ValueChanged<String> onPressed, bool isDisabled) {
    return Column(
      children: items.map((item) {
        final isSelected = item == selectedItem;
        return SizedBox(
          width: double.infinity,
          height: 50.0,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (isSelected) {
                  return Colors.red.shade100; // 선택된 버튼 색상
                }
                if (isDisabled) {
                  return Colors.grey.shade300; // 비활성화 상태의 선택되지 않은 버튼 색상
                }
                return Colors.white; // 3열의 선택되지 않은 버튼 색상
              }),
              foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (isSelected) {
                  return Colors.red; // 선택된 버튼 텍스트 색상
                }
                if (isDisabled) {
                  return Colors.grey.shade700; // 비활성화 상태의 선택되지 않은 버튼 텍스트 색상
                }
                return Colors.black; // 3열의 선택되지 않은 버튼 텍스트 색상
              }),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // 테두리 곡률 없애기
                  side: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            onPressed: isDisabled
                ? null
                : () => onPressed(item), // 비활성화 여부에 따라 onPressed 설정
            child: Text(
              item,
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
        );
      }).toList(),
    );
  }
}
