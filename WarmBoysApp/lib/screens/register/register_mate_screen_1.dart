import 'package:flutter/material.dart';
import '../../utils/shared_preferences_helper.dart';

// 회원가입 스크린 1(메이트)
class RegisterMateScreen1 extends StatefulWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;

  RegisterMateScreen1({required this.onNextPage, required this.onPreviousPage});

  @override
  _RegisterMateScreen1State createState() => _RegisterMateScreen1State();
}

class _RegisterMateScreen1State extends State<RegisterMateScreen1> {
  List<String> _selectedActivities = [];

  @override
  void initState() {
    super.initState();
    _loadSelectedActivities(); // 저장된 활동들을 불러오는 메서드 호출
  }

  Future<void> _loadSelectedActivities() async {
    List<String>? activities =
        await SharedPreferencesHelper.getStringList('_activityType');
    if (activities != null) {
      setState(() {
        _selectedActivities = activities;
      });
    }
  }

  void _toggleSelection(String activity) {
    setState(() {
      if (_selectedActivities.contains(activity)) {
        _selectedActivities.remove(activity);
      } else {
        _selectedActivities.add(activity);
      }
      _saveSelectedActivities();
    });
  }

  Future<void> _saveSelectedActivities() async {
    await SharedPreferencesHelper.saveStringList(
        '_activityType', _selectedActivities);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('어떤 서비스를 제공할 수 있을까요?'),
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
            SizedBox(height: 40),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildIconText(Icons.home, '실내활동'),
                  _buildIconText(Icons.nature, '실외활동'),
                  _buildIconText(Icons.restaurant, '밥 챙겨주기'),
                  _buildIconText(Icons.book, '책 읽기'),
                  _buildIconText(Icons.volunteer_activism, '재능 기부'),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: ElevatedButton(
          onPressed: _selectedActivities.isNotEmpty
              ? () async {
                  await _saveSelectedActivities();
                  widget.onNextPage();
                }
              : null,
          child: Text('다음', style: TextStyle(fontSize: 20)),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            backgroundColor: Color.fromARGB(255, 224, 73, 81),
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    final isSelected = _selectedActivities.contains(text);
    return GestureDetector(
      onTap: () => _toggleSelection(text),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor:
                isSelected ? Color.fromARGB(255, 224, 73, 81) : Colors.grey,
            child: Icon(icon,
                size: 30, color: isSelected ? Colors.white : Colors.black),
          ),
          SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(
                fontSize: 16.0,
                color: isSelected
                    ? Color.fromARGB(255, 224, 73, 81)
                    : Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
