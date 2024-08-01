import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/member_symptom_scrollview.dart';
import '../../widgets/member_details_scrollview.dart';
import '../../widgets/autowrap_text_box.dart';

class PostScreen extends StatefulWidget {
  final String memberType;
  final String myUid;
  final String postId;
  final String seniorUid;
  final String seniorName;
  final String city;
  final String gu;
  final String dong;
  final String dependentType;
  final bool withPet;
  final bool withCam;
  final List<String> symptom;
  final String petInfo;
  final String symptomInfo;
  final String walkingType;
  final double rating;
  final int ratingCount;
  final String activityType;
  final DateTime startTime;
  final DateTime endTime;

  PostScreen({
    required this.memberType,
    required this.myUid,
    required this.postId,
    required this.seniorUid,
    required this.seniorName,
    required this.city,
    required this.gu,
    required this.dong,
    required this.dependentType,
    required this.withPet,
    required this.withCam,
    required this.symptom,
    required this.petInfo,
    required this.symptomInfo,
    required this.walkingType,
    required this.rating,
    required this.ratingCount,
    required this.activityType,
    required this.startTime,
    required this.endTime,
  });

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String? selectedActivityType;
  String? selectedStartTime;
  String? selectedEndTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Senior Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileCard(),
              SizedBox(height: 20),
              _buildConditionalSection(),
              SizedBox(height: 20),
              Text(
                '회원 상세 정보',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              MemberDetailsScrollview(
                dependentType: widget.dependentType,
                withPet: widget.withPet,
                withCam: widget.withCam,
              ),
              SizedBox(height: 30),
              Text(
                '반려동물 상세 설명',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              AutowrapTextBox(text: widget.petInfo),
              SizedBox(height: 30),
              Text(
                '해당되는 증상',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              MemberSymptomScrollview(symptoms: widget.symptom),
              SizedBox(height: 30),
              Text(
                '증상 상세 설명',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              AutowrapTextBox(text: widget.symptomInfo),
              SizedBox(height: 30),
              Text(
                '거동 상태',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              MemberSymptomScrollview(symptoms: [widget.walkingType])
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.seniorName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('${widget.city} > ${widget.gu} > ${widget.dong}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${widget.rating.toStringAsFixed(2)} (${widget.ratingCount})'),
                      TextButton(
                        onPressed: () {},
                        child: Text('리뷰'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionalSection() {
    if (widget.memberType == '시니어' && widget.myUid != widget.seniorUid) {
      return _buildSeniorOtherSection();
    } else if (widget.memberType == '메이트') {
      return _buildMateSection();
    } else if (widget.memberType == '시니어' && widget.myUid == widget.seniorUid) {
      return _buildSeniorSelfSection();
    } else {
      return Container();
    }
  }

  Widget _buildSeniorOtherSection() {
    return _buildInfoBox([
      '활동 종류: ${widget.activityType}',
      '날짜: ${DateFormat('yy.M.d').format(widget.startTime)}',
      '시작 시간: ${DateFormat('HH:mm').format(widget.startTime)}',
      '종료 시간: ${DateFormat('HH:mm').format(widget.endTime)}',
    ]);
  }

  Widget _buildMateSection() {
    return _buildInfoBox([
      '활동 종류: ${widget.activityType}',
      '날짜: ${DateFormat('yy.M.d').format(widget.startTime)}',
      '시작 시간: ${DateFormat('HH:mm').format(widget.startTime)}',
      '종료 시간: ${DateFormat('HH:mm').format(widget.endTime)}',
    ], hasButton: true);
  }

  Widget _buildSeniorSelfSection() {
    return Column(
      children: [
        CalendarDatePicker(
          initialDate: widget.startTime,
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
          onDateChanged: (date) {
            setState(() {
              widget.startTime;
            });
          },
        ),
        _buildInfoBox([
          '활동 종류',
          '시작 시간',
          '종료 시간',
        ], isSelf: true),
      ],
    );
  }

  Widget _buildInfoBox(List<String> lines,
      {bool hasButton = false, bool isSelf = false}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var line in lines)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: isSelf ? _buildSelfLine(line) : Text(line),
              ),
            if (hasButton)
              ElevatedButton(
                onPressed: () {},
                child: Text('매칭 신청'),
              ),
            if (isSelf)
              ElevatedButton(
                onPressed: () {},
                child: Text('등록'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelfLine(String label) {
    if (label == '활동 종류') {
      return Row(
        children: [
          Text('$label: '),
          DropdownButton<String>(
            value: selectedActivityType,
            items: ['실내활동', '실외활동', '밥 챙겨주기', '책 읽기', '재능기부']
                .map((type) => DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedActivityType = value;
              });
            },
          ),
        ],
      );
    } else if (label == '시작 시간') {
      return Row(
        children: [
          Text('$label: '),
          DropdownButton<String>(
            value: selectedStartTime,
            items: List.generate(24, (index) {
              final hour = index < 12 ? index : index - 12;
              final period = index < 12 ? '오전' : '오후';
              final displayHour =
                  hour == 0 ? (period == '오전' ? '정오' : '자정') : '$period $hour시';
              return DropdownMenuItem<String>(
                value: displayHour,
                child: Text(displayHour),
              );
            }),
            onChanged: (value) {
              setState(() {
                selectedStartTime = value;
                selectedEndTime = null;
              });
            },
          ),
        ],
      );
    } else if (label == '종료 시간') {
      final startHour = int.tryParse(
              selectedStartTime?.split(' ')[1].replaceAll('시', '') ?? '0') ??
          0;
      final startPeriod = selectedStartTime?.split(' ')[0] ?? '오전';
      final startIndex = startPeriod == '오전' ? startHour : startHour + 12;
      return Row(
        children: [
          Text('$label: '),
          DropdownButton<String>(
            value: selectedEndTime,
            items: List.generate(24 - startIndex, (index) {
              final hour = (startIndex + index) < 12
                  ? (startIndex + index)
                  : (startIndex + index) - 12;
              final period = (startIndex + index) < 12 ? '오전' : '오후';
              final displayHour =
                  hour == 0 ? (period == '오전' ? '정오' : '자정') : '$period $hour시';
              return DropdownMenuItem<String>(
                value: displayHour,
                child: Text(displayHour),
              );
            }),
            onChanged: (value) {
              setState(() {
                selectedEndTime = value;
              });
            },
          ),
        ],
      );
    } else {
      return Text(label);
    }
  }
}
